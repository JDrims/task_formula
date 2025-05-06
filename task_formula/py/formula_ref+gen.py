import random
import math

def generate_signed_8bit():
    """Генерирует 8-битное знаковое число в дополнительном коде"""
    num = random.randint(-128, 127)
    return format(num & 0xFF, '08b')  # Маска для 8 бит

def int_to_signed_bin(num, bits):
    """Преобразует число в знаковое бинарное"""
    return format(num & ((1 << bits) - 1), f'0{bits}b')

def compute_q(a, b, c, d):
    """Вычисляет q = ((a - b) * (1 + 3 * c) - 4 * d) / 2"""
    return ((a - b) * (1 + 3 * c) - 4 * d) / 2

def math_round_q(q):
    """Округляет q по математическим правилам"""
    return math.floor(q + 0.5) if q >= 0 else math.ceil(q - 0.5)

with open('С:/test_cases.txt', 'w') as f:
    for _ in range(500):
        # Генерация 8-битных знаковых чисел
        a_bin = generate_signed_8bit()
        b_bin = generate_signed_8bit()
        c_bin = generate_signed_8bit()
        d_bin = generate_signed_8bit()
        
        # Преобразование в int (с учётом знака)
        a = int(a_bin, 2) if int(a_bin, 2) < 128 else int(a_bin, 2) - 256
        b = int(b_bin, 2) if int(b_bin, 2) < 128 else int(b_bin, 2) - 256
        c = int(c_bin, 2) if int(c_bin, 2) < 128 else int(c_bin, 2) - 256
        d = int(d_bin, 2) if int(d_bin, 2) < 128 else int(d_bin, 2) - 256
        
        # Вычисление q и преобразование в 21-битное знаковое
        q = compute_q(a, b, c, d)
        q_round = math_round_q(q)
        q_bin = int_to_signed_bin(int(q_round), 22)
        q_bin_int = int(q_bin, 2) if int(q_bin, 2) < 2**21 else int(q_bin, 2) - 2**22
        
        str = 0
        # Запись в файл
        f.write(f"{a_bin.zfill(22)}\n{b_bin.zfill(22)}\n{c_bin.zfill(22)}\n{d_bin.zfill(22)}\n{q_bin}\n")
        # f.write(f"{q} {q_round} {q_bin_int}\n")


print("'С:/test_cases.txt'")
