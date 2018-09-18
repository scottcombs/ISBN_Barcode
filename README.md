# ISBN_Barcode
An EAN-13 barcode generator that saves barcode as a vector graphic in pdf format.

Years ago, my daughter and I made this project in QT. Now, it doesn't compile without extensive recoding. Since it had to be done I decided to rewrite it in Cocoa.

What the app does is takes an EAN-13 number and builds a barcode. The interesting part is, you don't need to load any fonts or embed those fonts. The app converts the glyphs to outlines when saving or printing to a pdf file.

This project is helpful for anyone wishing to convert an NSString to outlines and saved into an NSBezierPath object.

To use the app, one simply puts the appropriate information into the NSTextFields. The BarcodeView is updated upon commiting the text to any of the user items on the MainView.

There is some tooltips to answer how to add a valid price extension and the general use of the buttons and fields.
