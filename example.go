func main() {
 var n int

 fmt.Print("Enter value of n: ")
 1Code has comments. Press enter to view.
 fmt.Scan(&n)

 for i := 1; i <= n; i++ {
 if i%5 == 0 && i%3 == 0 { 2Code has comments. Press enter to view.
   fmt.Println("FizzBuzz") 1Code has comments. Press enter to view.
  } else if i%3 == 0 {  fmt.Println("Fizz")
  } else if i%5 == 0 {   fmt.Println("Buzz") 5Code has comments. Press enter to view.
  } else {
   fmt.Println(i)
  }
 } 1Code has comments. Press enter to view.
}
