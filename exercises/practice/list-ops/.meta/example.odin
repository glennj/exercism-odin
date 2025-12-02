package list_ops

my_append :: proc(list1, list2: []int) -> []int {
	result: [dynamic]int
	for elem in list1 { append(&result, elem) }
	for elem in list2 { append(&result, elem) }
	return result[:]
}

/*
concat :: proc() -> string {
    // Implement this procedure.
    return ""
}
*/

my_filter :: proc(list: []int, func: proc(x: int) -> bool) -> []int {
	result: [dynamic]int
	for elem in list {
		if func(elem) {
			append(&result, elem)
		}
	}
	return result[:]
}

my_map :: proc(list: []int, func: proc(x: int) -> int) -> []int {
	result := make([]int, my_length(list))
	for elem, i in list {
		result[i] = func(elem)
	}
	return result[:]
}

my_length :: proc(list: []$E) -> (n: int) {
	for _ in list { n += 1 }
	return
}

my_reverse :: proc(list: []$E) -> []E {
	result := make([dynamic]E)
	for elem in list {
		inject_at(&result, 0, elem)
	}
	return result[:]
}

foldl :: proc(list: []$E, func: proc(acc, elem: E) -> E, init: E) -> E {
	result := init
	for elem in list {
		result = func(result, elem)
	}
	return result
}

foldr :: proc(list: []$E, func: proc(acc, elem: E) -> E, init: E) -> E {
	reversed := my_reverse(list)
	defer delete(reversed)

	return foldl(reversed, func, init)
}
