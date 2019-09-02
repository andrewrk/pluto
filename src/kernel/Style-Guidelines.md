# Style Guidelines

Into

## Braces

All curly braces have to be on the same line.

### Functions

Yes

```zig
fn function_name() void {
    // Do something
}
```

No

```zig
fn function_name() void
{
    // Do something
}
```

### for

Yes

```zig
for (items) |item| {
    // Do something
}
```

No

```zig
for (items) |item|
{
    // Do something
}
```

### while

Yes

```zig
while (i < 10) |i += 1| {
    // Do something
}
```

No

```zig
while (i < 10) |i += 1|
{
    // Do something
}
```

### if/else

Yes

```zig
if (i == 10) {
    // Do something
} else if (i == 20) {
    // Do something
} else {
    // Do something
}
```

No

```zig
if (i == 10)
{
    // Do something
}
else if (i == 20)
{
    // Do something
}
else
{
    // Do something
}
```

---

## Spacing



---

## Types

### Defining

### Globals

### Locals

---

## Naming

### Globals

### Locals

### Parameters

---

## Ordering

---

## Commenting
