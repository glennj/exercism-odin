package list_ops

import "core:fmt"
import "core:testing"

/* ------------------------------------------------------------
 * A helper procedure to enable more helpful test failure output.
 * Stringify the slices and compare the strings.
 * If they don't match, the user will see the values.
 */
expect_slices_match :: proc(t: ^testing.T, actual, expected: []$E, loc := #caller_location) {
	result := fmt.aprintf("%v", actual) // this varname shows up in the test output
	exp_str := fmt.aprintf("%v", expected)
	defer {
		delete(result)
		delete(exp_str)
	}

	testing.expect_value(t, result, exp_str)
}

@(test)
test_append_entries_to_a_list_and_return_the_new_list__empty_lists :: proc(t: ^testing.T) {
	list1 := []int{}
	list2 := []int{}
	result := my_append(list1, list2)
	defer delete(result)

	expected: []int = nil

	expect_slices_match(t, result, expected)
}

@(test)
test_append_entries_to_a_list_and_return_the_new_list__list_to_empty_list :: proc(t: ^testing.T) {
	list1 := []int{}
	list2 := []int{1, 2, 3, 4}
	result := my_append(list1[:], list2[:])
	defer delete(result)

	expected := []int{1, 2, 3, 4}

	expect_slices_match(t, result, expected)
}

@(test)
test_append_entries_to_a_list_and_return_the_new_list__empty_list_to_list :: proc(t: ^testing.T) {
	list1 := []int{1, 2, 3, 4}
	list2 := []int{}
	result := my_append(list1[:], list2[:])
	defer delete(result)

	expected := []int{1, 2, 3, 4}

	expect_slices_match(t, result, expected)
}

@(test)
test_append_entries_to_a_list_and_return_the_new_list__non_empty_lists :: proc(t: ^testing.T) {
	list1 := []int{1, 2}
	list2 := []int{2, 3, 4, 5}
	result := my_append(list1[:], list2[:])
	defer delete(result)

	expected := []int{1, 2, 2, 3, 4, 5}

	expect_slices_match(t, result, expected)
}

/* TODO research AoA
@(test)
test_concatenate_a_list_of_lists__empty_list :: proc(t: ^testing.T) {
    input := `{"lists":[]}`
    result := concat(input)
    expected := []

    testing.expect_value(t, result, expected)
}

@(test)
test_concatenate_a_list_of_lists__list_of_lists :: proc(t: ^testing.T) {
    input := `{"lists":[[1,2],[3],[],[4,5,6]]}`
    result := concat(input)
    expected := [1,2,3,4,5,6]

    testing.expect_value(t, result, expected)
}

@(test)
test_concatenate_a_list_of_lists__list_of_nested_lists :: proc(t: ^testing.T) {
    input := `{"lists":[[[1],[2]],[[3]],[[]],[[4,5,6]]]}`
    result := concat(input)
    expected := [[1],[2],[3],[],[4,5,6]]

    testing.expect_value(t, result, expected)
}
*/

@(test)
test_filter_list_returning_only_values_that_satisfy_the_filter_function__empty_list :: proc(
	t: ^testing.T,
) {
	list := []int{}
	func := proc(x: int) -> bool { return x % 2 == 1 }
	result := my_filter(list, func)
	defer delete(result)

	expected := []int{}

	expect_slices_match(t, result, expected)
}

@(test)
test_filter_list_returning_only_values_that_satisfy_the_filter_function__non_empty_list :: proc(
	t: ^testing.T,
) {
	list := []int{1, 2, 3, 4, 5}
	func := proc(x: int) -> bool { return x % 2 == 1 }
	result := my_filter(list, func)
	defer delete(result)

	expected := []int{1, 3, 5}

	expect_slices_match(t, result, expected)
}

@(test)
test_returns_the_length_of_a_list__empty_list :: proc(t: ^testing.T) {
	list := []int{}
	result := my_length(list)

	expected := 0

	testing.expect_value(t, result, expected)
}

@(test)
test_returns_the_length_of_a_list__non_empty_list :: proc(t: ^testing.T) {
	list := []int{1, 2, 3, 4}
	result := my_length(list)
	expected := 4

	testing.expect_value(t, result, expected)
}

@(test)
test_return_a_list_of_elements_whose_values_equal_the_list_value_transformed_by_the_mapping_function__empty_list :: proc(
	t: ^testing.T,
) {
	list := []int{}
	func := proc(x: int) -> int { return x + 1 }
	result := my_map(list, func)
	defer delete(result)

	expected := []int{}

	expect_slices_match(t, result, expected)
}

@(test)
test_return_a_list_of_elements_whose_values_equal_the_list_value_transformed_by_the_mapping_function__non_empty_list :: proc(
	t: ^testing.T,
) {
	list := []int{1, 3, 5, 7}
	func := proc(x: int) -> int { return x + 1 }
	result := my_map(list, func)
	defer delete(result)

	expected := []int{2, 4, 6, 8}

	expect_slices_match(t, result, expected)
}

@(test)
test_folds_reduces_the_given_list_from_the_left_with_a_function__empty_list :: proc(
	t: ^testing.T,
) {
	list := []int{}
	func := proc(acc, x: int) -> int { return x * acc }
	init := 2
	result := foldl(list, func, init)

	expected := 2

	testing.expect_value(t, result, expected)
}

@(test)
test_folds_reduces_the_given_list_from_the_left_with_a_function__direction_independent_function_applied_to_non_empty_list :: proc(
	t: ^testing.T,
) {
	list := []int{1, 2, 3, 4}
	func := proc(acc, x: int) -> int { return x + acc }
	init := 5
	result := foldl(list, func, init)

	expected := 15

	testing.expect_value(t, result, expected)
}

@(test)
test_folds_reduces_the_given_list_from_the_left_with_a_function__direction_dependent_function_applied_to_non_empty_list :: proc(
	t: ^testing.T,
) {
	list := []f64{1, 2, 3, 4}
	func := proc(acc, x: f64) -> f64 { return x / acc }
	init := 24.0
	result := foldl(list, func, init)

	expected := 64.0

	testing.expect_value(t, result, expected)
}

@(test)
test_folds_reduces_the_given_list_from_the_right_with_a_function__empty_list :: proc(
	t: ^testing.T,
) {
	list := []int{}
	func := proc(acc, x: int) -> int { return x * acc }
	init := 2
	result := foldr(list, func, init)

	expected := 2

	testing.expect_value(t, result, expected)
}

@(test)
test_folds_reduces_the_given_list_from_the_right_with_a_function__direction_independent_function_applied_to_non_empty_list :: proc(
	t: ^testing.T,
) {
	list := []int{1, 2, 3, 4}
	func := proc(acc, x: int) -> int { return x + acc }
	init := 5
	result := foldr(list, func, init)

	expected := 15

	testing.expect_value(t, result, expected)
}

@(test)
test_folds_reduces_the_given_list_from_the_right_with_a_function__direction_dependent_function_applied_to_non_empty_list :: proc(
	t: ^testing.T,
) {
	list := []f64{1, 2, 3, 4}
	func := proc(acc, x: f64) -> f64 { return x / acc }
	init := 24.0
	result := foldr(list, func, init)

	expected := 9.0

	testing.expect_value(t, result, expected)
}

@(test)
test_reverse_the_elements_of_the_list__empty_list :: proc(t: ^testing.T) {
	list := []int{}
	result := my_reverse(list)
	defer delete(result)

	expected := []int{}

	expect_slices_match(t, result, expected)
}

@(test)
test_reverse_the_elements_of_the_list__non_empty_list :: proc(t: ^testing.T) {
	list := []int{1, 3, 5, 7}
	result := my_reverse(list)
	defer delete(result)

	expected := []int{7, 5, 3, 1}

	expect_slices_match(t, result, expected)
}
/*

/*
@(test)
test_reverse_the_elements_of_the_list__list_of_lists_is_not_flattened :: proc(t: ^testing.T) {
    input := `{"list":[[1,2],[3],[],[4,5,6]]}`
    result := my_reverse(input)
    expected := [[4,5,6],[],[3],[1,2]]

    testing.expect_value(t, result, expected)
}
*/
*/
