/*
 Deinitialization
 
 Release resources that require custom cleanup.
 
 **** JUST For Class ****
 */

//MARK: - How Deinitialization Works

//Class definitions can have at most one deinitializer per class. The deinitializer doesn’t take any parameters and is written without parentheses:
// 특징은 파라메터가 없고, 소괄호를 갖지 않음. 하나 이상의 디이니셜라이저를 가질 수 없음.
// Deinitializers are called automatically, just before instance deallocation takes place.
// 자동으로 호출되며, 인스턴스가 해제된 직후 호출됨
// 해제되기 이전이므로 모든 값들에 접근이 가능하며, 슈퍼클래스의 소멸자는 서브클래스의 소멸자에서 호출하지 않아도 자동으로 호출된다.

/*
 syntax
 
 deinit {
     // perform the deinitialization
 }
 */

//MARK: How Deinitialization Works -



//MARK: - Deinitializers in Action

class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    deinit {
        print("deinit 호출")
        Bank.receive(coins: coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// Prints "A new player has joined the game with 100 coins"
print("There are now \(Bank.coinsInBank) coins left in the bank")
// Prints "There are now 9900 coins left in the bank"


playerOne!.win(coins: 2_000)
print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
// Prints "PlayerOne won 2000 coins & now has 2100 coins"
print("The bank now only has \(Bank.coinsInBank) coins left")
// Prints "The bank now only has 7900 coins left"

playerOne = nil
print("PlayerOne has left the game")
// Prints "PlayerOne has left the game"
print("The bank now has \(Bank.coinsInBank) coins")
// Prints "The bank now has 10000 coins"

//MARK: Deinitializers in Action -
