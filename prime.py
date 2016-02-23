import time
# import math

# a = 4000000
# #a = 200
# list_1 = []
# list_2 = []

# for i in range(a):
# 	if i!=0 and (i+1)%2 and (i+1)%3 and (i+1)%5 and (i+1)%7 and (i+1)%11 \
# 		and (i+1)%13 and (i+1)%17 and (i+1)%19 and (i+1)%23:
# 		list_1.append(i+1)

# while(list_1):
#     b = list_1.pop(0)
#     list_2.append(b)
#     list_3 = []
#     for i in list_1:
# 	    if i%b:
# 		    list_3.append(i)
#     list_1 = list_3
		
# # print list_2
# print sum(list_2) + 2 + 3 + 5 + 7 + 11 + 13 + 17 + 19 +23

# list_1 = [False for x in range(a)]

# i=2
# while i<a:
	# if not list_1[i]:
		# j = i * i
		# if j > a:
			# break
		# if i == 2:
			# while j<a:
				# list_1[j] = True
				# j += i
		# else:
			# while j<a:
				# list_1[j] = True
				# j = j + i + i

# print sum(filter(lambda x:not x, list_1))
			
if __name__ == "__main__":
	n = 4000000
	start = time.time()
	if n < 2:
        print []
	if n == 2:
		print [2]
	s = range(3, n, 2)
	mroot = n ** 0.5
	half = len(s)

	i = 0
	m = 3
	# print 's:', s
	while m <= mroot:
		if s[i]:
			# print m
			j = (m*m - 3)//2
			# print j
			# print s[j]
			s[j] = 0
			j += m
			while j < half:
				s[j] = 0
				j += m

		i += 1
		m = 2*i+3

	# print [2] + [x for x in s if x]
	print sum(s) + 2
	end = time.time()
	print end - start
