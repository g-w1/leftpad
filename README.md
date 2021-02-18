# leftpad

String pad left

# Install
`gyro add leftpad`

# Test
`zig build test`

pad strings to the left

Usage: 

```zig
const padded = try leftpad(allocator, "hope we dont have the npm problem", 3, '.');
defer allocator.free(padded);
expectEqualSlices(u8, "...hope we dont have the npm problem", padded);
```

Note: if supplied 0 for the 4th argument, ' ' will be used for the character to pad.
