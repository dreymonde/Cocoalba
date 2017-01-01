precedencegroup Apply {
    associativity: left
    lowerThan: AdditionPrecedence
}

infix operator <* : Apply

func <* <T, V> (lhs: T, rhs: (T) -> V) -> V {
    return rhs(lhs)
}
