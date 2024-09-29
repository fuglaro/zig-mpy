import os
os.chdir(__file__.rpartition("/")[0])

import root

print("Factorial 10 (3628800): %s" % root.factorial(10))

print("Add 3 + 7 (10): %s" % root.add(3, 7))
