# Kipple

This is an umbrella module, meant simply for implicitly exporting all modules within this package.

> [^CAUTION]
> Usage of underscored attributes such as `@_exported` is strongly discouraged, as the `_` prefix
> indicates properties that are used internally by compiler and standard library developers.
>
> That said, the biggest risk for `@_exported` is that you'll need to update the syntax and/or
> manually import some modules in the event of a Swift version bump that impacts the signature or behavior of the attribute.

## How It Works

If you wanted to consume all modules within this package, you'd normally have to import them individually within every file.

```swift
import KippleA
import KippleB
import KippleC
import KippleD
```

However, the `@_exported` declaration allows us to implicitly import certain modules anytime this module is imported. You can see it in action in `Exports.swift`. It looks a little something like this:

```swift
@_exported import KippleA
@_exported import KippleB
@_exported import KippleC
@_exported import KippleD
```

Now, you can use a single import statement to import all modules.

```swift
import Kipple
```

## More Information

- [Underscored Attributes -- apple/swift](https://github.com/apple/swift/blob/main/docs/ReferenceGuides/UnderscoredAttributes.md)
- [What does `@_exported import` do? -- Swift Forums](https://forums.swift.org/t/what-does-exported-import-do/35869)
