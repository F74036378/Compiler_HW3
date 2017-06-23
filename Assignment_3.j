.class public main
.super java/lang/Object
.method public static main([Ljava/lang/String;)V
	.limit stack 10
	.limit locals 10
ldc 4
istore 0 
iload 0
ldc 10
imul 
istore 1
iload 1
ldc 40 
getstatic java/lang/System/out Ljava/io/PrintStream;
swap		;swap the top two items on the stack 
invokevirtual java/io/PrintStream/println(I)V
iload 1
ldc 3
ldc 2
iadd 
ldc 5
idiv 
istore 0
iload 0
ldc 8 
getstatic java/lang/System/out Ljava/io/PrintStream;
swap		;swap the top two items on the stack 
invokevirtual java/io/PrintStream/println(I)V
ldc "Hello"
 
getstatic java/lang/System/out Ljava/io/PrintStream;
swap		;swap the top two items on the stack 
invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
return
.end method
