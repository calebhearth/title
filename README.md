# Title

[![Build Status](https://travis-ci.org/calebthompson/title.svg)](https://travis-ci.org/calebthompson/title)
[![Code Climate](https://codeclimate.com/github/calebthompson/title.svg)](https://codeclimate.com/github/calebthompson/title)
[![Coverage Status](https://coveralls.io/repos/calebthompson/title/badge.svg)](https://coveralls.io/r/calebthompson/title)

Translations for \<title\>s!

## Usage

Add to your translations:

```yaml
en:
  titles:
    # titles.application defaults to the sigficant portion of
    # AppName::Application, which would be:
    application: AppName
    dashboards:
      show: Dashboard
    users:
      show: '%{user}'
      new: Registration
```

And to your HTML:

```erb
<title><%= title %></title>
```

And to your `User` model:

```ruby
def to_s
  name
end
```

You can pass additional values to the `#title` helper, which can be referenced
in your translations:

```erb
<title><%= title(user_name: current_user.name) %></title>
```

```yaml
en:
  titles:
    application: '%{user_name} - AppName'
```

## Acknowledgement

Though the idea of translating titles was arrived at seperately, [Brandon
Keepers] wrote [Abusing Rails I18N to Set Page Titles] which outlines an
extremely similar approach, and from whence came the idea of using the view
context to get local assigns to be used in interpolation.

[Brandon Keepers]: https://github.com/bkeepers
[Abusing Rails I18N to Set Page Titles]: http://opensoul.org/blog/archives/2012/11/05/abusing-rails-i18n-to-set-page-titles/
