book_price = 800

def total(basket):
    unique_books = len(set(basket))
    number_of_books_purchased = len(basket)

    price = 0
    if unique_books == 1:
        price = book_price
    if unique_books == 2:
        price = discount_for_quantity(unique_books, 5)
    if unique_books == 3:
        price = discount_for_quantity(unique_books, 10)
    if unique_books == 4:
        price = discount_for_quantity(unique_books, 20)
    if unique_books == 5:
        price = discount_for_quantity(unique_books, 25)
    
    if (number_of_books_purchased > unique_books):
        price += (number_of_books_purchased - unique_books) * book_price

    return price

def discount_for_quantity(quantity, discount):
    return book_price * quantity - ((book_price * quantity) * discount / 100)