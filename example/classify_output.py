import os
import math

GOLDEN_FILE = "baseline/golden_std_output"

def load_file(path):
    try:
        with open(path, "r") as f:
            return f.read().strip()
    except:
        return None

golden_output = load_file(GOLDEN_FILE)

def classify_dir(dirname):
    
    readable_files = 0
    
    crash_or_hang = 0
    masked = 0
    silent_data_corruptor = 0
    
    for fname in os.listdir(dirname):
        full_path = os.path.join(dirname, fname)
        
        if os.path.isfile(full_path):
            
            try:
                with open(full_path, "r") as curr_file:
                    
                    readable_files += 1
                    
                    # print(f'now reading file: {fname}')
                    curr_file_contents = curr_file.read().strip()
                    
                    if not any(char.isdigit() for char in curr_file_contents):
                        # print("potential crash/hang?")
                        print(f'{fname} crashed/hung')
                        crash_or_hang += 1

                    elif curr_file_contents == golden_output:
                        # print(f"same as golden output?")
                        # note to self: masked means we injected a fault, but it did not propogate to user
                        # therefore, it gave semantically correct output
                        masked += 1 
                    else:
                        # print(f"different than golden output?")
                        silent_data_corruptor += 1
                    
                    # print('\n')
                    
            except FileNotFoundError:
                print(f'{fname} does not exist!')
                
            except Exception as exception:
                print(f'Something bad happened {exception}')
                
    return {"MASKED": masked, 
            "SDC": silent_data_corruptor, 
            "CRASH/HANG": crash_or_hang}

print("Unoptimized:")
print(classify_dir("unoptimized_output/"))

print("\nUnroll4x:")
print(classify_dir("loop_unroll4/"))