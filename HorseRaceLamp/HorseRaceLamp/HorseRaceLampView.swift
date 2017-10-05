//
//  HorseRaceLampView.swift
//  SwiftProject
//
//  Created by Ric on 3/10/17.
//  Copyright © 2017年 Ric. All rights reserved.
//

import UIKit

class HorseRaceLampView: UIScrollView {
    
    
    var rollSpeed:CGFloat = 0.5
    private var rollLabel:UILabel = UILabel()
    private var _timer:Timer?
    private var totalRect:CGRect=CGRect.zero// rollLaber totalRect
    private var _isCanRoll:Bool = false// rollLabel can scroll
    var timeInterval:TimeInterval = 0.01//  _timer  default 0.01
    
    //MARK:- init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        rollLabel = UILabel.init()
        self.addSubview(rollLabel)
    }
    
    init(frame: CGRect,font:UIFont,color:UIColor) {
        super.init(frame: frame)
        rollLabel = UILabel.init()
        rollLabel.font = font
        rollLabel.textColor = color
        self.addSubview(rollLabel)
    }
    var font:UIFont = UIFont.systemFont(ofSize: 12){
        didSet{
            
            rollLabel.font = font
        }
    }
    
    var textColor:UIColor = UIColor.black{
        didSet{
            
            rollLabel.textColor = textColor
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        _timer?.invalidate()
        _timer=nil
    }

    
    var text:String=""{
        
        didSet{
            
            rollLabel.text = text
            var size:CGSize = self.getFontSize(font:(rollLabel.font)!,size:CGSize(width: CGFloat(MAXFLOAT), height:15),text: text)
            if size.width > self.frame.size.width{
                _isCanRoll = true
                if _timer != nil {
                    _timer?.invalidate()
                    _timer=nil
                }
                
                _timer = Timer.scheduledTimer(timeInterval: (timeInterval <= 0 ? 0.01 :timeInterval), target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
                RunLoop.current.add(_timer!, forMode: RunLoopMode.commonModes)
                _timer?.fireDate = Date.distantFuture
            }else{
                size.width = self.frame.size.width
            }
            totalRect = CGRect(x: 0, y: 0, width: size.width, height: self.frame.size.height)
            self.resetStart()
        }
    }
    
    func timerAction(){
        var r:CGRect = rollLabel.frame
        r.origin.x = r.origin.x-(rollSpeed <= 0 ? 0.5 : rollSpeed)
        rollLabel.frame = r
        if(-r.origin.x > (rollLabel.frame.size.width)-self.frame.size.width){
            r.origin.x=0
            self.pauseRoll()
            self.perform(#selector(resetStart), with: nil, afterDelay: 0.5)
        }
    }
    
    func resetStart(){
        rollLabel.frame = totalRect
        self.startRoll()
    }
    
    func startRoll(){
        if _timer == nil  {return}
        if _timer?.isValid == false  {return}
        if _isCanRoll{
            self.perform(#selector(start), with: nil, afterDelay: 1)
        }
    }
    
    func start(){
        _timer?.fireDate = Date()
    }
    
    func pauseRoll(){
        if _timer == nil  {return}
        if _timer?.isValid == false  {return}
        if _isCanRoll{
            _timer?.fireDate = Date.distantFuture
        }
    }
    
    func getFontSize(font:UIFont,size:CGSize,text:String?)->CGSize{
        
        if text != nil {
            let textRect = text?.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:font], context: nil)
            let size:CGSize = (textRect?.size)!
            return size
        }
        
        return CGSize.zero
    }
}
