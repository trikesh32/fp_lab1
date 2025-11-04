#!/usr/bin/env python3

import subprocess
import sys

def test_euler4():
    """Test Euler4 implementation"""
    result = subprocess.run([sys.executable, 'Euler4.py'], capture_output=True, text=True)
    output = result.stdout.strip()
    expected = "906609"
    
    if expected in output:
        print(f"✓ Euler4 test passed: found {expected}")
        return True
    else:
        print(f"✗ Euler4 test failed: expected {expected}, got output: {output}")
        return False

def test_euler27():
    """Test Euler27 implementation"""
    result = subprocess.run([sys.executable, 'Euler27.py'], capture_output=True, text=True)
    output = result.stdout.strip()
    expected = "-59231"
    
    if expected in output:
        print(f"✓ Euler27 test passed: found {expected}")
        return True
    else:
        print(f"✗ Euler27 test failed: expected {expected}, got output: {output}")
        return False

if __name__ == "__main__":
    success1 = test_euler4()
    success2 = test_euler27()
    
    if success1 and success2:
        print("All tests passed!")
        sys.exit(0)
    else:
        print("Some tests failed!")
        sys.exit(1)