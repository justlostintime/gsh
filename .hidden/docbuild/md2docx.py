#!/usr/bin/env python3
"""Rebuild the body of the gsh manual docx from the wiki Documentation.md.

Keeps the original title page, table of contents field, styles, headers, footers and section
properties; replaces everything from the first Heading1 (Introduction) on with the markdown,
using the same pandoc style names as the original. Only the markdown the manual uses is handled
(GFM rules): headings, paragraphs, fenced and indented code, "- " lists, bold, italic, code spans,
links, backslash escapes and hard line breaks.

The version and date lines before the first ## heading ("Version 1.8", "**November 21, 2026**")
replace the version and date on the title page.

usage: md2docx.py Documentation.md unpacked_docx_dir      (normally run by build.sh)
"""
import re
import sys
from xml.sax.saxutils import escape as _esc

md_path, root = sys.argv[1], sys.argv[2]
doc_path = root + '/word/document.xml'
rels_path = root + '/word/_rels/document.xml.rels'

def esc(s):
    return _esc(s, {'"': '&quot;', "'": '&apos;'})

# ---------------------------------------------------------------- hyperlinks
rels = open(rels_path, encoding='utf-8').read()
link_ids = {}
for m in re.finditer(r'<Relationship Id="([^"]+)" Type="[^"]*/hyperlink" Target="([^"]*)"', rels):
    link_ids.setdefault(m.group(2), m.group(1))
new_rels = []
used_ids = set(re.findall(r'Id="([^"]+)"', rels))

def link_id(url):
    key = esc(url)
    if key not in link_ids:
        k = 1
        while 'rIdLink%d' % k in used_ids:
            k += 1
        rid = 'rIdLink%d' % k
        used_ids.add(rid)
        link_ids[key] = rid
        new_rels.append('<Relationship Id="%s" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/hyperlink" Target="%s" TargetMode="External"/>' % (rid, key))
    return link_ids[key]

# ---------------------------------------------------------------- inline markup
PUNCT = set('!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~')

def run(text, bold=False, italic=False, code=False):
    if text == '':
        return ''
    rpr = ''
    if code:
        rpr += '<w:rStyle w:val="VerbatimChar"/>'
    if bold:
        rpr += '<w:b/><w:bCs/>'
    if italic:
        rpr += '<w:i/><w:iCs/>'
    parts = text.split('\t')
    out = []
    for i, p in enumerate(parts):
        if i:
            out.append('<w:tab/>')
        if p:
            out.append('<w:t xml:space="preserve">%s</w:t>' % esc(p))
    return '<w:r><w:rPr>%s</w:rPr>%s</w:r>' % (rpr, ''.join(out))

def br():
    return '<w:r><w:rPr></w:rPr><w:br/></w:r>'

def tokens(s):
    """Split inline text into ('text', s) ('code', s) ('br',) ('link', text, url) ('em', marker) tokens."""
    out = []
    buf = ''
    i = 0
    n = len(s)
    while i < n:
        c = s[i]
        if c == '\\' and i + 1 < n and s[i + 1] == '\n':
            out.append(('text', buf)); buf = ''
            out.append(('br',)); i += 2; continue
        if c == '\\' and i + 1 < n and s[i + 1] in PUNCT:
            buf += s[i + 1]; i += 2; continue
        if c == '`':
            j = i
            while j < n and s[j] == '`':
                j += 1
            ticks = s[i:j]
            k = s.find(ticks, j)
            while k != -1 and k + len(ticks) < n and s[k + len(ticks)] == '`':
                k = s.find(ticks, k + len(ticks) + 1)
            if k == -1:
                buf += ticks; i = j; continue
            content = s[j:k].replace('\n', ' ')
            if len(content) > 2 and content[0] == ' ' and content[-1] == ' ' and content.strip():
                content = content[1:-1]
            out.append(('text', buf)); buf = ''
            out.append(('code', content)); i = k + len(ticks); continue
        if c == '<':
            m = re.match(r'<((?:https?|ftp)://[^>\s]+)>', s[i:])
            if m:
                out.append(('text', buf)); buf = ''
                out.append(('link', m.group(1), m.group(1))); i += m.end(); continue
        if c == '[':
            m = re.match(r'\[([^\]]*)\]\(([^)\s]+)\)', s[i:], flags=re.S)
            if m:
                out.append(('text', buf)); buf = ''
                out.append(('link', m.group(1), m.group(2))); i += m.end(); continue
        if c == '*':
            j = i
            while j < n and s[j] == '*':
                j += 1
            out.append(('text', buf)); buf = ''
            prev = s[i - 1] if i else ' '
            nxt = s[j] if j < n else ' '
            out.append(('em', s[i:j], not nxt.isspace(), not prev.isspace()))
            i = j; continue
        if c == '\n':
            buf += ' '; i += 1; continue
        buf += c; i += 1
    out.append(('text', buf))
    return [t for t in out if not (t[0] == 'text' and t[1] == '')]

def inline(s):
    """Inline markdown to runs. Emphasis delimiters pair up left to right; unmatched ones stay as text."""
    toks = tokens(s.strip())
    # pair * runs: an opener can open (followed by non-space), a closer can close (preceded by non-space)
    pairs = {}
    stack = []
    for idx, t in enumerate(toks):
        if t[0] != 'em':
            continue
        marker, can_open, can_close = t[1], t[2], t[3]
        opener = None
        if can_close:
            for k in range(len(stack) - 1, -1, -1):
                if toks[stack[k]][1] == marker:
                    opener = k
                    break
        if opener is not None:
            pairs[stack[opener]] = idx
            pairs[idx] = stack[opener]
            del stack[opener:]
        elif can_open:
            stack.append(idx)
    out = []
    bold = italic = 0
    for idx, t in enumerate(toks):
        kind = t[0]
        if kind == 'em':
            if idx not in pairs:
                out.append(run(t[1], bold > 0, italic > 0))
                continue
            opening = pairs[idx] > idx
            d = 1 if opening else -1
            if len(t[1]) >= 2:
                bold += d
            if len(t[1]) % 2 == 1:
                italic += d
        elif kind == 'text':
            out.append(run(t[1], bold > 0, italic > 0))
        elif kind == 'code':
            out.append(run(t[1], bold > 0, italic > 0, code=True))
        elif kind == 'br':
            out.append(br())
        elif kind == 'link':
            label = inline(t[1]) if t[1] != t[2] else run(t[1])
            label = label.replace('<w:rPr>', '<w:rPr><w:rStyle w:val="Hyperlink"/>')
            out.append('<w:hyperlink r:id="%s">%s</w:hyperlink>' % (link_id(t[2]), label))
    return ''.join(out)

# ---------------------------------------------------------------- blocks
def para(style, body, extra=''):
    return '<w:p><w:pPr><w:pStyle w:val="%s"/>%s<w:rPr></w:rPr></w:pPr>%s</w:p>' % (style, extra, body)

def heading(level, text):
    num = '<w:numPr><w:ilvl w:val="%d"/><w:numId w:val="1"/></w:numPr>' % (level - 1)
    return para('Heading%d' % level, inline(text), num)

def code_block(lines):
    while lines and lines[-1].strip() == '':
        lines.pop()
    body = []
    for i, l in enumerate(lines):
        if i:
            body.append(br())
        body.append(run(l, code=True))
    return para('SourceCode', ''.join(body))

def list_item(text):
    return para('Compact', inline(text), '<w:numPr><w:ilvl w:val="0"/><w:numId w:val="2"/></w:numPr>')

FENCE = re.compile(r'^( {0,3})(`{3,}|~{3,})')
HEAD = re.compile(r'^(#{1,6})\s+(.*?)\s*#*\s*$')
ITEM = re.compile(r'^( {0,3})[-*+]\s+(.*)$')

lines = open(md_path, encoding='utf-8').read().split('\n')
# the title, version and date are on the title page of the docx: start at the first ## heading
start = next(i for i, l in enumerate(lines) if l.startswith('## '))
front = [l.strip().strip('*').strip() for l in lines[:start] if l.strip() and not l.startswith('#')]
version = next((l for l in front if l.startswith('Version ')), None)
date = next((l for l in front if re.match(r'^[A-Z][a-z]+ \d{1,2}, \d{4}$', l)), None)
lines = lines[start:]

out = []
first = True          # the next paragraph follows a heading or a code block
after_list = False    # the next paragraph follows a list item
i = 0
n = len(lines)
para_lines = []

def flush_para():
    global para_lines, first, after_list
    if para_lines:
        text = '\n'.join(para_lines)
        space = '<w:spacing w:before="180"/>' if after_list else ''
        out.append(para('FirstParagraph' if first else 'BodyText', inline(text), space))
        first = False
        after_list = False
        para_lines = []

def block_start(l):
    return FENCE.match(l) or HEAD.match(l) or ITEM.match(l)

while i < n:
    l = lines[i]
    m = FENCE.match(l)
    if m:
        flush_para()
        indent, fence = len(m.group(1)), m.group(2)
        body = []
        i += 1
        while i < n and not (lines[i].lstrip(' ').startswith(fence[0] * len(fence)) and lines[i].strip().strip(fence[0]) == '' and len(lines[i]) - len(lines[i].lstrip(' ')) <= 3):
            b = lines[i]
            strip = min(indent, len(b) - len(b.lstrip(' ')))
            body.append(b[strip:])
            i += 1
        i += 1
        out.append(code_block(body))
        first = True
        after_list = False
        continue
    m = HEAD.match(l)
    if m:
        flush_para()
        level = len(m.group(1)) - 1          # ## is Heading1 in the docx
        out.append(heading(max(1, min(level, 9)), m.group(2)))
        first = True
        after_list = False
        i += 1
        continue
    m = ITEM.match(l)
    if m:
        flush_para()
        item = [m.group(2)]
        i += 1
        while i < n and lines[i].strip() != '' and not block_start(lines[i]):
            item.append(lines[i].strip())
            i += 1
        out.append(list_item('\n'.join(item)))
        first = False
        after_list = True
        continue
    if l.strip() == '':
        flush_para()
        i += 1
        continue
    if not para_lines and l.startswith('    '):
        body = []
        while i < n and (lines[i].startswith('    ') or lines[i].strip() == ''):
            body.append(lines[i][4:])
            i += 1
        out.append(code_block(body))
        first = True
        continue
    para_lines.append(l)
    i += 1
flush_para()

# ---------------------------------------------------------------- assemble
x = open(doc_path, encoding='utf-8').read()
h = x.index('<w:p><w:pPr><w:pStyle w:val="Heading1"/>')
s = x.rindex('<w:sectPr')
title = x[:h]
def set_title(pattern, text):
    """Replace the text of the title page paragraph whose text matches pattern"""
    global title
    if not text:
        return
    for p in re.findall(r'<w:p[ >](?:(?!</w:p>).)*</w:p>', title, flags=re.S):
        t = ''.join(re.findall(r'<w:t[^>]*>([^<]*)</w:t>', p))
        if re.match(pattern, t.strip()):
            texts = re.findall(r'<w:t[^>]*>[^<]*</w:t>', p)
            q = p.replace(texts[0], '<w:t xml:space="preserve">%s</w:t>' % esc(text), 1)
            for extra in texts[1:]:
                q = q.replace(extra, '<w:t></w:t>', 1)
            title = title.replace(p, q, 1)
            return
    print('title page: no paragraph matches', pattern)
set_title(r'^Version \S+$', version)
set_title(r'^[A-Z][a-z]+ \d{1,2}, \d{4}$', date)
x = title + ''.join(out) + x[s:]
open(doc_path, 'w', encoding='utf-8').write(x)
if new_rels:
    rels = rels.replace('</Relationships>', ''.join(new_rels) + '</Relationships>')
    open(rels_path, 'w', encoding='utf-8').write(rels)
print('blocks', len(out), 'new links', len(new_rels))
