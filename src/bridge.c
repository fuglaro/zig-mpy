//////////
// Bridges between the micropython modules and the zig library.
// Only wraps functions in root.zig that should be called
// from micropython.
//

// Include the header file to get access to the MicroPython API
#include "py/dynruntime.h"

// Include the header for all enternally referenced zig functions.
#include "root.h"


// Example: add - demo for passing two arguments.
static mp_obj_t add_wrapper(mp_obj_t x_obj, mp_obj_t y_obj) {
    return mp_obj_new_int(add(mp_obj_get_int(x_obj), mp_obj_get_int(y_obj)));
}
static MP_DEFINE_CONST_FUN_OBJ_2(add_obj, add_wrapper);

// Example: increment - demo for using varables with static lifetime.
static mp_obj_t increment_wrapper() {
    return mp_obj_new_int(increment());
}
static MP_DEFINE_CONST_FUN_OBJ_0(increment_obj, increment_wrapper);


// Example: original mpy native example moved to Zig

/* Reimplemented in Zig. See root.zig.
 * // Helper function to compute factorial
 * static mp_int_t factorial_helper(mp_int_t x) {
 *    if (x == 0) {
 *        return 1;
 *    }
 *    return x * factorial_helper(x - 1);
 *}
 */

// This is the function which will be called from Python, as factorial(x)
static mp_obj_t factorial(mp_obj_t x_obj) {
    // Extract the integer from the MicroPython input object
    mp_int_t x = mp_obj_get_int(x_obj);
    // Calculate the factorial
    mp_int_t result = factorial_helper(x);
    // Convert the result to a MicroPython integer object and return it
    return mp_obj_new_int(result);
}
// Define a Python reference to the function above
static MP_DEFINE_CONST_FUN_OBJ_1(factorial_obj, factorial);


// This is the entry point and is called when the module is imported
mp_obj_t mpy_init(mp_obj_fun_bc_t *self, size_t n_args, size_t n_kw, mp_obj_t *args) {
    // This must be first, it sets up the globals dict and other things
    MP_DYNRUNTIME_INIT_ENTRY

    // Make the function available in the module's namespace
    mp_store_global(MP_QSTR_factorial, MP_OBJ_FROM_PTR(&factorial_obj));
    mp_store_global(MP_QSTR_add, MP_OBJ_FROM_PTR(&add_obj));
    mp_store_global(MP_QSTR_increment, MP_OBJ_FROM_PTR(&increment_obj));

    // This must be last, it restores the globals dict
    MP_DYNRUNTIME_INIT_EXIT
}
