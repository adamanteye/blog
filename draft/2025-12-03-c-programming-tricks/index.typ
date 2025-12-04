#import "../../page.typ": conf
#import "meta.typ": desc, title
#show: conf.with(title: title, desc: desc)

= Introduction

The following code snippets compile with both gcc and clang.

= GNU C extensions

== Statement expression

Those familiar with rust ususally intend to evaluate code blocks as an
expression, which hides temperoray or local variables.

And you can do the same thing in C, which is known as #link(
  "https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html",
)[statement expression]:

```c
int foo(int input)
{
	int output = ({
		int tmp = 2;
		input + tmp;
	});
	return output;
}
```

While the above seems a little boring, another use case shows its importance:

```c
#define maxint(a, b)                    \
	({                              \
		int _a = (a), _b = (b); \
		_a > _b ? _a : _b;      \
	})
```

This esures that `(a)` or `(b)` is exactly evaluated once to avoid side effects.
