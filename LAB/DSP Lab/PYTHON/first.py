import numpy as np
import matplotlib.pyplot as plt

n = np.arange(0, 18)
sig1 = np.sin(np.pi * n)
sig2 = np.sin((np.pi / 2) * n)
sig3 = np.sin((np.pi / 4) * n)

plt.figure(figsize=(8, 5))
plt.stem(n, sig1, linefmt='r-', markerfmt='ro', basefmt=' ', label='ω=π')
plt.stem(n, sig2, linefmt='g-', markerfmt='go', basefmt=' ', label='ω=π/2')
plt.stem(n, sig3, linefmt='b-', markerfmt='bo', basefmt=' ', label='ω=π/4')

plt.title("Oscillation Rate for Different Frequencies", fontweight='bold')
plt.legend()
plt.grid(True)
plt.show() 