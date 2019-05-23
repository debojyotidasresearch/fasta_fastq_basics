#!/usr/local/bin/python

def factorial(n):
	if n < 0 : return "Invalid input"
	elif n == 0 : return 1
	else:
		p = n
		while(n>=2):
			n = n - 1
			p = p * n
			return p

n = int(input("Enter a positive integer:"))

print(factorial(n))
