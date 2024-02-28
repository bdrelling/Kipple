# Kipple

This is an umbrella module, meant simply for implicitly exporting all modules within this package.

This allows you to use a single import statement to import all modules.

```swift
import Kipple
```

Rather than the alternative, which can get quite verbose.

```swift
import KippleA
import KippleB
import KippleC
import KippleD
```

This works by using the `@_exported` declaration, which you can see in `Exports.swift`.

```swift
@_exported import KippleA
@_exported import KippleB
@_exported import KippleC
@_exported import KippleD
```

For more information, see:

- [What does `@_exported import` do? -- Swift Forums](https://forums.swift.org/t/what-does-exported-import-do/35869)
