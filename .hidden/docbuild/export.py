#!/usr/bin/python3
"""Open a docx in headless LibreOffice, update its table of contents and save it as docx and pdf.

usage: /usr/bin/python3 export.py in.docx out.docx out.pdf
Needs the python3-uno package, the system python (/usr/bin/python3) has it.
"""
import os
import subprocess
import sys
import tempfile
import time

import uno
from com.sun.star.beans import PropertyValue


def pv(name, value):
    p = PropertyValue()
    p.Name = name
    p.Value = value
    return p


def url(path):
    return uno.systemPathToFileUrl(os.path.abspath(path))


src, out_docx, out_pdf = sys.argv[1:4]
port = 2083
with tempfile.TemporaryDirectory() as profile:
    office = subprocess.Popen(['soffice', '--headless', '--invisible', '--norestore',
                               '-env:UserInstallation=' + url(profile),
                               '--accept=socket,host=localhost,port=%d;urp;' % port])
    try:
        ctx = uno.getComponentContext()
        resolver = ctx.ServiceManager.createInstanceWithContext('com.sun.star.bridge.UnoUrlResolver', ctx)
        for _ in range(60):
            try:
                remote = resolver.resolve('uno:socket,host=localhost,port=%d;urp;StarOffice.ComponentContext' % port)
                break
            except Exception:
                time.sleep(1)
        else:
            sys.exit('LibreOffice did not start')
        desktop = remote.ServiceManager.createInstanceWithContext('com.sun.star.frame.Desktop', remote)
        doc = desktop.loadComponentFromURL(url(src), '_blank', 0, (pv('Hidden', True),))
        indexes = doc.getDocumentIndexes()
        for i in range(indexes.getCount()):
            indexes.getByIndex(i).update()
        doc.refresh()
        doc.storeToURL(url(out_docx), (pv('FilterName', 'MS Word 2007 XML'),))
        doc.storeToURL(url(out_pdf), (pv('FilterName', 'writer_pdf_Export'),))
        doc.close(True)
        try:
            desktop.terminate()
        except Exception:
            pass
    finally:
        try:
            office.wait(timeout=30)
        except subprocess.TimeoutExpired:
            office.kill()
print('written', out_docx, out_pdf)
