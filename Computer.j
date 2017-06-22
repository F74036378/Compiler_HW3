.class public main
.super java/lang/Object
.method public static main([Ljava/lang/String;)V
	.limit stack 10
	.limit locals 10
ldc 0
istore 0 
ldc "Hello"
 
getstatic java/lang/System/out Ljava/io/PrintStream;
swap		;swap the top two items on the stack 
invokevirtual java/io/PrintStream/println(Ljava/lang/String;)V
return
.end method
