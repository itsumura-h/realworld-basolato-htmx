type
  Unit = enum
    JPY, USD

  Currency[T] = object
    amount: float64

proc `+`[T](a, b: Currency[T]): Currency[T] =
  result = Currency[T](amount: a.amount + b.amount)

proc `-`[T](a, b: Currency[T]): Currency[T] =
  result = Currency[T](amount: a.amount - b.amount)

proc main() =
  var jpy1 = Currency[Unit.JPY](amount: 1000.0)
  var jpy2 = Currency[Unit.JPY](amount: 2000.0)

  var total_jpy = jpy1 + jpy2
  echo "Total JPY: ", total_jpy.amount

  var usd1 = Currency[Unit.USD](amount: 50.0)
  var usd2 = Currency[Unit.USD](amount: 100.0)

  var total_usd = usd1 + usd2
  echo "Total USD: ", total_usd.amount

  let jpy3 = jpy1 * jpy2 # 掛け算はエラー
  echo "JPY3: ", jpy3.amount

main()
