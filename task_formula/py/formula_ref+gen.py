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
    """Вычисляет q = ((a - b) * (1 + 3 * c) - 4 * d) // 2"""
    return ((a - b) * (1 + 3 * c) - 4 * d) // 2  # Используем целочисленное деление

def sign_extend(bin_str, bits):
    """Расширяет битовую строку с учётом знака"""
    if len(bin_str) >= bits:
        return bin_str
    sign_bit = bin_str[0] if bin_str else '0'
    return sign_bit * (bits - len(bin_str)) + bin_str

with open('C:/test_cases.txt', 'w') as f:
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
        
        # Вычисление q (целочисленное)
        q = compute_q(a, b, c, d)
        q_bin = int_to_signed_bin(q, 22)
        
        # Запись в файл с правильным расширением знака
        f.write(f"{sign_extend(a_bin, 22)}\n")
        f.write(f"{sign_extend(b_bin, 22)}\n")
        f.write(f"{sign_extend(c_bin, 22)}\n")
        f.write(f"{sign_extend(d_bin, 22)}\n")
        f.write(f"{q_bin}\n")

print("Файл 'C:/test_cases.txt' успешно создан")