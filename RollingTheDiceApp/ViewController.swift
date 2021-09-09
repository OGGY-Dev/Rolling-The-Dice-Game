//
//  ViewController.swift
//  RollingTheDiceApp
//
//  Created by Oğulcan DEMİRTAŞ on 9.09.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var p1LabelScore: UILabel!
    @IBOutlet weak var p2LabelScore: UILabel!
    @IBOutlet weak var p1Point: UILabel!
    @IBOutlet weak var p2Point: UILabel!
    @IBOutlet weak var p2Status: UIImageView!
    @IBOutlet weak var p1Status: UIImageView!
    @IBOutlet weak var dice1img: UIImageView!
    @IBOutlet weak var dice2img: UIImageView!
    @IBOutlet weak var setresultLabel: UILabel!
    
    
    var playerPoints = (player1Point: 0, player2Point: 0)
    var playerScores = (p1Score: 0, p2Score: 0)
    var playerTurn: Int = 1
    
    var maxSetNumber: Int = 5
    var currentSet: Int = 1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //closure
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) { //işlemler 5 saniye sonra başlayacak
            
        }
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "arkaPlan")!)
        
        
        
    }

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        //dice randoms when user shakes the device
        //kullanıcı telefonu salladığında işlemler gerçekleşcek. Bu kod telefon sallama kodu
        if currentSet > maxSetNumber {
            return  //mevcut set sayısı max set sayısının aşarsa durdurcak
        }
        diceRandoms()
    }
    
    
    
    func setResult(dice1: Int, dice2: Int) {
        
        if playerTurn == 1 {
            //yeni set başlamıştır
            playerPoints.player1Point = dice1 + dice2
            p1Point.text = String(playerPoints.player1Point)
            p1Status.image = UIImage(named: "bekle")
            p2Status.image = UIImage(named: "onay")
            
            setresultLabel.text = "2. Player's Turn"
            playerTurn = 2
            p2Point.text = "0"
            
        }else{
            
            playerPoints.player2Point = dice1 + dice2
            p2Point.text = String(playerPoints.player2Point)
            p2Status.image = UIImage(named: "bekle")
            p1Status.image = UIImage(named: "onay")
        
            setresultLabel.text = "1. Player's Turn"
            playerTurn = 1
          
            
            //seti bitirme işlemleri
            if playerPoints.player1Point > playerPoints.player2Point{
                //1. oyuncu oyunu kazandı
                playerScores.p1Score += 1
                setresultLabel.text = "Player 1 wins \(currentSet). Set"
                currentSet += 1
                p1LabelScore.text = String(playerScores.p1Score)
            }else if playerPoints.player2Point > playerPoints.player1Point{
                playerScores.p2Score += 1
                setresultLabel.text = "Player 2 wins \(currentSet). Set"
                currentSet += 1
                p2LabelScore.text = String(playerScores.p2Score)
            }else{
                //berabere kalmak
                //set sayısı değişmemeli
                setresultLabel.text = "\(currentSet). Set is Draw"
            }
            
            playerPoints.player1Point = 0
            playerPoints.player2Point = 0
            
        }
        
        
    }
    
    
    func diceRandoms() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
            //işlemi yapmadan önce 3 saniye bekletiyoruz programımız daha güzel görünsün diye
        
        
        let dice1 = arc4random_uniform(6) + 1 //üst sınırımız 6 olacak minimum da 1 olacaktır.
        let dice2 = arc4random_uniform(6) + 1
        
            self.dice1img.image = UIImage(named: String(dice1)) //gelen zar değerine göre assests ten image çağırıyoruz
            self.dice2img.image = UIImage(named: String(dice2))
        
            self.setResult(dice1: Int(dice1), dice2: Int(dice1))
        
            if self.currentSet > self.maxSetNumber {
            
                if self.playerScores.p1Score > self.playerScores.p2Score {
                    self.setresultLabel.text = "Player 1 Wins"
                
            }else {
                self.setresultLabel.text = "Player 2 Wins"
            }
            
        }
            
        }
        
        setresultLabel.text = "Waiting for dice for \(playerTurn). Player"
        dice1img.image = UIImage(named: "bilinmeyenZar")
        dice2img.image = UIImage(named: "bilinmeyenZar")
    }
    

    
    
}

