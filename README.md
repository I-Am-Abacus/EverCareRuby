# The Everest Team\'s WebApp

Rails element of web app to to manage Care Provision for vulnerable people.



NB The application as demonstrated on the night at SyncTheCity did not integrate calls of this back-end, due to an issue with maintaining session after sign-on. This is an issue we could have resolved with a little more time - probably by not using SessionStore. Note that this is the first time I have written any application that integrates with a front-end.

Please also note that we're aware this app has some workarounds & inconsistencies in API calling that would be cleaned up with a little more time for research. 



This application is based on elemets of the following (for user / session / static page support):-

    # Ruby on Rails Tutorial: sample application

    This is the sample application for
    the [*Ruby on Rails Tutorial*](http://railstutorial.org/)
    by [Michael Hartl](http://michaelhartl.com/).


    From http://www.railstutorial.org/book/frontmatter#copyright_and_license:-
    Copyright and license

    Ruby on Rails Tutorial: Learn Web Development with Rails. Copyright © 2013 by Michael Hartl. All source code in the Ruby on Rails Tutorial is available jointly under the MIT License and the Beerware License.

    The MIT License

    Copyright (c) 2013 Michael Hartl

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.

    /*
     * ----------------------------------------------------------------------------
     * "THE BEER-WARE LICENSE" (Revision 42):
     * Michael Hartl wrote this code. As long as you retain this notice you
     * can do whatever you want with this stuff. If we meet some day, and you think
     * this stuff is worth it, you can buy me a beer in return.
     * ----------------------------------------------------------------------------
     */


Please ignore any elements relating to the accounts model - while these are not in the code from the above tutorial, they are also not used in this application.