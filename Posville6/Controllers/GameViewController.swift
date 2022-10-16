//
//  GameViewController.swift
//  Posville6
//
//  Created by kimhyeongmin on 2022/10/15.
//

import UIKit

class GameViewController: UIViewController {
	
    var quizManager = QuizManager.shared
    var quizzes: [Quiz] = []
    
	@IBOutlet weak var player0Image: UIImageView!
	@IBOutlet weak var player1Image: UIImageView!
	@IBOutlet weak var player2Image: UIImageView!
	@IBOutlet weak var player3Image: UIImageView!
	@IBOutlet weak var player4Image: UIImageView!
	@IBOutlet weak var player5Image: UIImageView!
	
	@IBOutlet weak var questionLabel: UILabel!
	@IBOutlet weak var questionView: UIView!
	@IBOutlet weak var threeButtonView: UIView!
	@IBOutlet weak var twoButtonView: UIView!
	@IBOutlet weak var button2_1: UIButton!
	@IBOutlet weak var button2_2: UIButton!
	@IBOutlet weak var button3_1: UIButton!
	@IBOutlet weak var button3_2: UIButton!
	@IBOutlet weak var button3_3: UIButton!
    
    var category: Category = .all
    var gameMode: GameMode = .normal
    var playerIndex: [Int]?
    var loserCount: Int?
    var currentLoserCount: Int?
    
    lazy var playerImages: [UIImageView] = [
        player0Image, player1Image, player2Image, player3Image, player4Image, player5Image
    ]
	
	@IBOutlet weak var timeBar: UIProgressView!
	
	var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeBar.progress = 0.0
		setupUI()
        setupQuiz()
        setupQuestionView()
        imageSetup()
    }
    
    func setupUI() {
        // 문제를 띄워주는 view에 그림자 효과
        questionView.layer.shadowOpacity = 0.3
        questionView.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        questionView.layer.shadowRadius = 4
        questionView.layer.shadowColor = UIColor.black.withAlphaComponent(0.25).cgColor
    }
    
    func setupQuiz() {
        quizzes = quizManager.fetchQuizzes(category: category).shuffled()
    }
    
    func setupQuestionView() {
        guard let quiz = quizzes.popLast() else {
            print("Quiz Error")
            return
        }
        
        switch quiz.options.count {
        case 2:
            questionLabel.text = quiz.question
            
            threeButtonView.alpha = 0
            threeButtonView.isUserInteractionEnabled = false
            
            let options = quiz.options.shuffled()
            button2_1.setTitle(options[0], for: .normal)
            button2_2.setTitle(options[1], for: .normal)
            
        case 3:
            questionLabel.text = quiz.question
            
            twoButtonView.alpha = 0
            twoButtonView.isUserInteractionEnabled = false
            
            let options = quiz.options.shuffled()
            button3_1.setTitle(options[0], for: .normal)
            button3_2.setTitle(options[1], for: .normal)
            button3_3.setTitle(options[2], for: .normal)
            
        default:
            print("Quiz options Error")
            return
        }
//        view.setNeedsLayout()
    }
    
    // 선택된 플레이어의 자리에만 플레이어 이미지를 보여줍니다
    func imageSetup() {
        for idx in playerIndex! {
            playerImages[idx].image = UIImage(named: "player\(idx)")
        }
    }
	
	// TODO: button3_2 버튼을 눌렀을 때 액션이 되게 임시로 설정해놨는데 추후 뷰가 변경되었을 때 액션하도록 변경
	@IBAction func buttonPressForTest(_ sender: Any) {
		
		var progress: Float = 0.0
		timeBar.progress = progress
		
		// withTimeInterval로 시간 변경
		// TODO: 임시로 설정해 놓은 withTimeInterval 파라미터 0.01을 추후 교체
		timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
			progress += 0.01
			self.timeBar.progress = progress
			
			if self.timeBar.progress == 1.0 {
				self.timeBar.progress = 0.0
				timer.invalidate()
			}
		})
	}
	  
    // TODO: 일시정지 버튼 Alert 구현
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
//        let alert = UIAlertController(title: "일시정지", message: "게임에서 정말 나가시겠습니까?", preferredStyle: .alert)
//        let cancel = UIAlertAction(title: "취소", style: .default)
//        let exit = UIAlertAction(title: "나가기", style: .cancel)
//        alert.addAction(exit)
//        alert.addAction(cancel)
//        present(alert, animated: true)
    }
}
