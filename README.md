# jekyll-evernote_rss

## Synopsis

This is a small [jekyll](https://github.com/mojombo/jekyll) plugin for integrating a public Evernote notebook into your blog via RSS. The code's not pretty yet, but functional.

Kudos to [Christian Hellsten](https://github.com/christianhellsten) for code inspiration.

## Requirements

* Paul Dix's [feedzirra](https://github.com/pauldix/feedzirra) gem  
  `gem install feedzirra` or add it to your Jekyll blog's Gemfile and run `bundle`

## Usage

Simply integrate the evernote_rss tag into the desired page and define the following attributes:

* Mandatory attributes:
  * **username**: String - Your Evernote username, e.g. johndoe
  * **notebook**: String - The public notebook's name, e.g. articles
* Optional attributes:
  * **count**: Integer - Defines how many articles will be displayed, default is 10

Here's a [twitter bootstrap](http://twitter.github.com/bootstrap/) backed example with a table structure:

    <table class="table table-striped">
      <thead>
        <th>Title</th>
        <th>Date</th>
      </thead>
      <tbody>
        {% evernote_rss username:fooforge notebook:public count:20 %}
          <tr>
            <td><a href='{{ item.url }}'>{{ item.title }}</a></td>
            <td>{{ item.published }}</td>
          </tr>
        {% endevernote_rss %}
      </tbody>
    </table>
    
The RSS feed provides the following items:

* `{{ item.url }}` - A note's URL
* `{{ item.title }}` - The note's title
* `{{ item.published }}` - Date of publication
* `{{ item.summary }}` - Preview of the note's content
    
A working example can be seen on [fooforge.com](http://fooforge.com/bookmarks.html).

## Known bugs

### Direct links in Safari

When trying to access a [specific article](http://www.evernote.com/pub/fooforge/public#n=5984d261-2ad4-4fb6-ae0a-2b6b2d18cc2a) in Safari you'll get redirected to the public notebook's [home](http://www.evernote.com/pub/fooforge/public) URL. Told Evernote about it, hopefully they'll get this fixed soon.

## Development

* Source hosted at [GitHub](https://github.com/fooforge/jekyll-evernote_rss)
* Report issues/Questions/Feature requests on [GitHub](https://github.com/fooforge/jekyll-evernote_rss/issues) as well

Pull requests are very welcome! Make sure your patches are well tested.

## License

Copyright (c) 2012 Mike Adolphs

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.