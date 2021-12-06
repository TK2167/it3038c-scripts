import random
import math
print("Enter number range to guess from")
lower = int(input("Enter Lowest number: "))
upper = int(input("Enter Highest number: "))
x = random.randint(lower, upper)
print("\n\tYou have ", round(math.log(upper - lower + 1, 2)), " more chances to guess!\n")
count = 0
while count < math.log(upper - lower + 1, 2):
	count += 1
	guess = int(input("Guess the number: "))
	if x == guess:
		print("Congratulations you guessed it in ",
			count, " tries")
		break
	elif x > guess:
		print("Guess Higher!")
	elif x < guess:
		print("Guess Lower!")
if count >= math.log(upper - lower + 1, 2):
	print("\nThe number was %d" % x)
	print("\tTry again!")
