# Title

Translations for \<title\>s!

## Usage

Add to your translations:

```yaml
en:
  titles:
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
