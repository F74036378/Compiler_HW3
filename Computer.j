.class public main
.super java/lang/Object
.method public static main([Ljava/lang/String;)V
	.limit stack 10
	.limit locals 10
getstatic java/lang/System/out Ljava/io/PrintStream;
swap		;swap the top two items on the stack 
invokevirtual java/io/PrintStream/println(I)V
ldc 18
ldc 1
ldc 2
iadd 
ldc 3
imul 
getstatic java/lang/System/out Ljava/io/PrintStream;
swap		;swap the top two items on the stack 
invokevirtual java/io/PrintStream/println(I)V
iload a
getstatic java/lang/System/out Ljava/io/PrintStream;
swap		;swap the top two items on the stack 
invokevirtual java/io/PrintStream/println(I)V
getstatic java/lang/System/out Ljava/io/PrintStream;
swap		;swap the top two items on the stack 
invokevirtual java/io/PrintStream/println(I)V
getstatic java/lang/System/out Ljava/io/PrintStream;
swap		;swap the top two items on the stack 
invokevirtual java/io/PrintStream/println(I)V
getstatic java/lang/System/out Ljava/io/PrintStream;
swap		;swap the top two items on the stack 
invokevirtual java/io/PrintStream/println(I)V
iload a
iload b
imul 
getstatic java/lang/System/out Ljava/io/PrintStream;
swap		;swap the top two items on the stack 
invokevirtual java/io/PrintStream/println(I)V
return
.end method
