# LibArchiveRubyFs

Copyright (c) 2009 SUGAWARA Genki <sgwr_dts@yahoo.co.jp>

Copyright (c) 2014 FlavourSys Technology GmbH <technology@flavoursys.com>

## Description

This is a (reduced) fork of the [LibArchive/Ruby](https://bitbucket.org/winebarrel/libarchive-ruby/) gem written by Genki Sugawara. We needed the gem to be aware of the `pkg-config` configuration of `libarchive` and especially non-standard installation locations.

## Major Changes

* Dropped Win32 support.
* Require `pkg-config`, add non-standard installation location of `libarchive.so` to dynamic linker's search path via `-rpath`.
* Renamed to avoid name collision.
* Moved to GitHub.
* Converted line endings to Unix :bowtie:

## License

    Copyright (c) 2009 SUGAWARA Genki <sgwr_dts@yahoo.co.jp>
    Copyright (c) 2014 FlavourSys Technology GmbH <technology@flavoursys.com>
    All rights reserved.
    
    Redistribution and use in source and binary forms, with or without modification,
    are permitted provided that the following conditions are met:
    
        * Redistributions of source code must retain the above copyright notice, 
          this list of conditions and the following disclaimer.
        * Redistributions in binary form must reproduce the above copyright notice, 
          this list of conditions and the following disclaimer in the documentation 
          and/or other materials provided with the distribution.
        * The names of its contributors may be used to endorse or promote products 
           derived from this software without specific prior written permission.
    
    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND 
    ANY EXPRESS OR IMPLIED WARRANTIES,
    INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND 
    FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT 
    OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, 
    EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT 
    OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
    INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, 
    STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY 
    OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH 
    DAMAGE.
