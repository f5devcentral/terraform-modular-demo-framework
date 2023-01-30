resource local_file test {
    filename = format("%s%s", path.module, "/garbage.txt")
    content = "ignore this file"
}