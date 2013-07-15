//
//  NSString+Jive.m
//  jive-ios-sdk
//
//  Created by Orson Bushnell on 5/16/13.
//
//    Copyright 2013 Jive Software Inc.
//    Licensed under the Apache License, Version 2.0 (the "License");
//    you may not use this file except in compliance with the License.
//    You may obtain a copy of the License at
//    http://www.apache.org/licenses/LICENSE-2.0
//
//    Unless required by applicable law or agreed to in writing, software
//    distributed under the License is distributed on an "AS IS" BASIS,
//    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//    See the License for the specific language governing permissions and
//    limitations under the License.
//

#import "NSString+Jive.h"

@implementation NSString (Jive)

- (NSString *)mimeTypeFromExtension {
    static NSDictionary *mimeTypesByExtension = nil;
    if (!mimeTypesByExtension) {
        // from http://webdesign.about.com/od/multimedia/a/mime-types-by-file-extension.htm
        mimeTypesByExtension = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"text/h323", @"323",
                                @"application/internet-property-stream", @"acx",
                                @"application/postscript", @"ai",
                                @"audio/x-aiff", @"aif",
                                @"audio/x-aiff", @"aifc",
                                @"audio/x-aiff", @"aiff",
                                @"video/x-ms-asf", @"asf",
                                @"video/x-ms-asf", @"asr",
                                @"video/x-ms-asf", @"asx",
                                @"audio/basic", @"au",
                                @"video/x-msvideo", @"avi",
                                @"application/olescript", @"axs",
                                @"text/plain", @"bas",
                                @"application/x-bcpio", @"bcpio",
                                @"application/octet-stream", @"bin",
                                @"image/bmp", @"bmp",
                                @"text/plain", @"c",
                                @"application/vnd.ms-pkiseccat", @"cat",
                                @"application/x-cdf", @"cdf",
                                @"application/x-netcdf", @"cdf",
                                @"application/x-x509-ca-cert", @"cer",
                                @"application/octet-stream", @"class",
                                @"application/x-msclip", @"clp",
                                @"image/x-cmx", @"cmx",
                                @"image/cis-cod", @"cod",
                                @"application/x-cpio", @"cpio",
                                @"application/x-mscardfile", @"crd",
                                @"application/pkix-crl", @"crl",
                                @"application/x-x509-ca-cert", @"crt",
                                @"application/x-csh", @"csh",
                                @"text/css", @"css",
                                @"application/x-director", @"dcr",
                                @"application/x-x509-ca-cert", @"der",
                                @"application/x-director", @"dir",
                                @"application/x-msdownload", @"dll",
                                @"application/octet-stream", @"dms",
                                @"application/msword", @"doc",
                                @"application/msword", @"dot",
                                @"application/x-dvi", @"dvi",
                                @"application/x-director", @"dxr",
                                @"application/postscript", @"eps",
                                @"text/x-setext", @"etx",
                                @"application/envoy", @"evy",
                                @"application/octet-stream", @"exe",
                                @"application/fractals", @"fif",
                                @"x-world/x-vrml", @"flr",
                                @"image/gif", @"gif",
                                @"application/x-gtar", @"gtar",
                                @"application/x-gzip", @"gz",
                                @"text/plain", @"h",
                                @"application/x-hdf", @"hdf",
                                @"application/winhlp", @"hlp",
                                @"application/mac-binhex40", @"hqx",
                                @"application/hta", @"hta",
                                @"text/x-component", @"htc",
                                @"text/html", @"htm",
                                @"text/html", @"html",
                                @"text/webviewhtml", @"htt",
                                @"image/x-icon", @"ico",
                                @"image/ief", @"ief",
                                @"application/x-iphone", @"iii",
                                @"application/x-internet-signup", @"ins",
                                @"application/x-internet-signup", @"isp",
                                @"image/pipeg", @"jfif",
                                @"image/jpeg", @"jpe",
                                @"image/jpeg", @"jpeg",
                                @"image/jpeg", @"jpg",
                                @"application/x-javascript", @"js",
                                @"application/x-latex", @"latex",
                                @"application/octet-stream", @"lha",
                                @"video/x-la-asf", @"lsf",
                                @"video/x-la-asf", @"lsx",
                                @"application/octet-stream", @"lzh",
                                @"application/x-msmediaview", @"m13",
                                @"application/x-msmediaview", @"m14",
                                @"audio/x-mpegurl", @"m3u",
                                @"application/x-troff-man", @"man",
                                @"application/x-msaccess", @"mdb",
                                @"application/x-troff-me", @"me",
                                @"message/rfc822", @"mht",
                                @"message/rfc822", @"mhtml",
                                @"audio/mid", @"mid",
                                @"application/x-msmoney", @"mny",
                                @"video/quicktime", @"mov",
                                @"video/x-sgi-movie", @"movie",
                                @"video/mpeg", @"mp2",
                                @"audio/mpeg", @"mp3",
                                @"video/mpeg", @"mpa",
                                @"video/mpeg", @"mpe",
                                @"video/mpeg", @"mpeg",
                                @"video/mpeg", @"mpg",
                                @"application/vnd.ms-project", @"mpp",
                                @"video/mpeg", @"mpv2",
                                @"application/x-troff-ms", @"ms",
                                @"application/vnd.ms-outlook", @"msg",
                                @"application/x-msmediaview", @"mvb",
                                @"application/x-netcdf", @"nc",
                                @"message/rfc822", @"nws",
                                @"application/oda", @"oda",
                                @"application/pkcs10", @"p10",
                                @"application/x-pkcs12", @"p12",
                                @"application/x-pkcs7-certificates", @"p7b",
                                @"application/x-pkcs7-mime", @"p7c",
                                @"application/x-pkcs7-mime", @"p7m",
                                @"application/x-pkcs7-certreqresp", @"p7r",
                                @"application/x-pkcs7-signature", @"p7s",
                                @"image/x-portable-bitmap", @"pbm",
                                @"application/pdf", @"pdf",
                                @"application/x-pkcs12", @"pfx",
                                @"image/x-portable-graymap", @"pgm",
                                @"application/ynd.ms-pkipko", @"pko",
                                @"application/x-perfmon", @"pma",
                                @"application/x-perfmon", @"pmc",
                                @"application/x-perfmon", @"pml",
                                @"application/x-perfmon", @"pmr",
                                @"application/x-perfmon", @"pmw",
                                @"image/x-portable-anymap", @"pnm",
                                @"application/vnd.ms-powerpoint", @"pot",
                                @"image/x-portable-pixmap", @"ppm",
                                @"application/vnd.ms-powerpoint", @"pps",
                                @"application/vnd.ms-powerpoint", @"ppt",
                                @"application/pics-rules", @"prf",
                                @"application/postscript", @"ps",
                                @"application/x-mspublisher", @"pub",
                                @"video/quicktime", @"qt",
                                @"audio/x-pn-realaudio", @"ra",
                                @"audio/x-pn-realaudio", @"ram",
                                @"image/x-cmu-raster", @"ras",
                                @"image/x-rgb", @"rgb",
                                @"audio/mid", @"rmi",
                                @"application/x-troff", @"roff",
                                @"application/rtf", @"rtf",
                                @"text/richtext", @"rtx",
                                @"application/x-msschedule", @"scd",
                                @"text/scriptlet", @"sct",
                                @"application/set-payment-initiation", @"setpay",
                                @"application/set-registration-initiation", @"setreg",
                                @"application/x-sh", @"sh",
                                @"application/x-shar", @"shar",
                                @"application/x-stuffit", @"sit",
                                @"audio/basic", @"snd",
                                @"application/x-pkcs7-certificates", @"spc",
                                @"application/futuresplash", @"spl",
                                @"application/x-wais-source", @"src",
                                @"application/vnd.ms-pkicertstore", @"sst",
                                @"application/vnd.ms-pkistl", @"stl",
                                @"text/html", @"stm",
                                @"application/x-sv4cpio", @"sv4cpio",
                                @"application/x-sv4crc", @"sv4crc",
                                @"image/svg+xml", @"svg",
                                @"application/x-shockwave-flash", @"swf",
                                @"application/x-troff", @"t",
                                @"application/x-tar", @"tar",
                                @"application/x-tcl", @"tcl",
                                @"application/x-tex", @"tex",
                                @"application/x-texinfo", @"texi",
                                @"application/x-texinfo", @"texinfo",
                                @"application/x-compressed", @"tgz",
                                @"image/tiff", @"tif",
                                @"image/tiff", @"tiff",
                                @"application/x-troff", @"tr",
                                @"application/x-msterminal", @"trm",
                                @"text/tab-separated-values", @"tsv",
                                @"text/plain", @"txt",
                                @"text/iuls", @"uls",
                                @"application/x-ustar", @"ustar",
                                @"text/x-vcard", @"vcf",
                                @"x-world/x-vrml", @"vrml",
                                @"audio/x-wav", @"wav",
                                @"application/vnd.ms-works", @"wcm",
                                @"application/vnd.ms-works", @"wdb",
                                @"application/vnd.ms-works", @"wks",
                                @"application/x-msmetafile", @"wmf",
                                @"application/vnd.ms-works", @"wps",
                                @"application/x-mswrite", @"wri",
                                @"x-world/x-vrml", @"wrl",
                                @"x-world/x-vrml", @"wrz",
                                @"x-world/x-vrml", @"xaf",
                                @"image/x-xbitmap", @"xbm",
                                @"application/vnd.ms-excel", @"xla",
                                @"application/vnd.ms-excel", @"xlc",
                                @"application/vnd.ms-excel", @"xlm",
                                @"application/vnd.ms-excel", @"xls",
                                @"application/vnd.ms-excel", @"xlt",
                                @"application/vnd.ms-excel", @"xlw",
                                @"x-world/x-vrml", @"xof",
                                @"image/x-xpixmap", @"xpm",
                                @"image/x-xwindowdump", @"xwd",
                                @"application/x-compress", @"z",
                                @"application/zip,", @"zip",
                                @"text/java", @"txt",
                                nil];
    }
    
    CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,
                                                            (__bridge CFStringRef) self,
                                                            NULL);
    NSString *fileMIMEType = (__bridge_transfer NSString *)UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType);
    
    CFRelease(UTI);
    if (!fileMIMEType) {
        fileMIMEType = mimeTypesByExtension[self];
        if (!fileMIMEType) {
            fileMIMEType = @"text/plain";
            NSLog(@"Unable to find MIME type for %@", self);
        }
    }
    
    return fileMIMEType;
}

@end
