//
//  FASteppedView.swift
//  
//
//  Created by Mac on 9/23/21.
//

import UIKit

@IBDesignable
public class FAStepped: UIView {
    
    open var titles = ["Step 1","Step 2","Step 3","Step 4"] {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var currentTab: Int = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var lineWidth: CGFloat = 2 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var activeColor: UIColor = UIColor.black {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var inactiveColor: UIColor = UIColor.lightGray {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var isCircle: Bool = true {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var isAnimation:Bool = true {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable open var isSpacing:Bool = true {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    private var pulseEffect:LFTPulseAnimation!
    
    
    public override func draw(_ rect: CGRect) {
        setStackViewlines()
        setStackViewSteps()
        setStackViewTitle()
    }
    
    
    func setStackViewSteps() {
        let stackViewSteps = UIStackView()
        stackViewSteps.axis = .horizontal
        stackViewSteps.alignment = .fill
        stackViewSteps.distribution = .equalCentering
        
        addSubview(stackViewSteps)
        stackViewSteps.translatesAutoresizingMaskIntoConstraints = false
        stackViewSteps.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        stackViewSteps.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        stackViewSteps.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stackViewSteps.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        var number = 1
        for _ in titles {
            let v = UIView()
            v.backgroundColor = .clear
            stackViewSteps.addArrangedSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
            v.widthAnchor.constraint(equalToConstant: 40).isActive = true
            v.heightAnchor.constraint(equalToConstant: 40).isActive = true
            
            let centerView = UIView(frame: CGRect(x: 5, y: 5, width: 30, height: 30))
            
            
            if isCircle {
                centerView.layer.cornerRadius = 15
            }else{
                centerView.layer.cornerRadius = 4
            }
            
            centerView.layer.masksToBounds = true
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            label.text = "\(number)"
            
            
            let image = UIImageView(frame: CGRect(x: 7.5, y: 7.5, width: 15, height: 15))
            image.image = UIImage(systemName: "checkmark")
            image.tintColor = .white
            centerView.layer.removeFromSuperlayer()
            
            if currentTab >= number {
                
                if currentTab == number {
                    centerView.backgroundColor = .white
                    label.textColor = activeColor
                    centerView.layer.borderColor = activeColor.cgColor
                    centerView.layer.borderWidth = lineWidth
                    centerView.addSubview(label)
                    
                    if isAnimation {
                        
                        applyPulseAnimation(parentView: v, childView: centerView)
                    }
                }else{
                    if pulseEffect != nil {
                        pulseEffect.removeFromSuperlayer()
                    }
                    self.animationColor(v: centerView, color: activeColor)
                    
                    label.textColor = .white
                    centerView.addSubview(image)
                }
            }else{
                
                label.textColor = inactiveColor
                centerView.backgroundColor = .white
                centerView.layer.borderColor = inactiveColor.cgColor
                centerView.layer.borderWidth = lineWidth
                centerView.addSubview(label)
            }
            
            v.addSubview(centerView)
            number += 1
        }
        
    }
    
    func setStackViewlines() {
        let stackViewlines = UIStackView()
        stackViewlines.axis = .horizontal
        stackViewlines.distribution = .fillEqually
        stackViewlines.spacing = (self.isSpacing) ? 40 : 20
        
        
        addSubview(stackViewlines)
        stackViewlines.translatesAutoresizingMaskIntoConstraints = false
        stackViewlines.leadingAnchor.constraint(equalTo: leadingAnchor, constant: (self.isSpacing) ? 55 : 40).isActive = true
        stackViewlines.trailingAnchor.constraint(equalTo: trailingAnchor, constant: (self.isSpacing) ? -55 : -40).isActive = true
        stackViewlines.heightAnchor.constraint(equalToConstant: lineWidth).isActive = true
        stackViewlines.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        
        if titles.count > 1 {
            var numbers = 1
            for _ in 1...(titles.count - 1) {
                let line = UIProgressView()
                line.progress = 0.0
                
                line.trackTintColor = inactiveColor
                if currentTab > numbers {
                    line.progressTintColor = activeColor
                    if (currentTab - 1) == numbers {
                        
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        UIView.animate(withDuration: 0.1, delay: 0, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                        line.setProgress(1.0, animated: true)
                      })
                    }
                        
                    }else{
                        line.progress = 1.0
                    }
                    
                }
                
                
                stackViewlines.addArrangedSubview(line)
                numbers += 1
            }
        }
    }
    
    func setStackViewTitle() {
        let stackViewTitle = UIStackView()
        stackViewTitle.axis = .horizontal
        stackViewTitle.distribution = .equalCentering
        addSubview(stackViewTitle)
        stackViewTitle.translatesAutoresizingMaskIntoConstraints = false
        stackViewTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        stackViewTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        stackViewTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        stackViewTitle.topAnchor.constraint(equalTo: topAnchor, constant: 40).isActive = true
        
        if titles.count > 1 {
            var numbers = 1
            for title in titles {
                let label = UILabel()
                label.text = title
                label.textAlignment = .center
                label.textColor = .gray
                label.font = UIFont.systemFont(ofSize: 12)
                if currentTab >= numbers {
                    label.textColor = .black
                    label.font = UIFont.boldSystemFont(ofSize: 12)
                }
                label.adjustsFontSizeToFitWidth = true
                label.translatesAutoresizingMaskIntoConstraints = false
                label.widthAnchor.constraint(equalToConstant: 70).isActive = true
                
                stackViewTitle.addArrangedSubview(label)
                
                numbers += 1
            }
            
        }
        
        
    }
    
    
    func animationColor(v:UIView, color:UIColor) {
        UIView.animate(withDuration: 2) {
            v.backgroundColor = color
        }
    }
    
    
    func applyPulseAnimation(parentView:UIView,childView:UIView){
        if pulseEffect != nil {
            pulseEffect.removeFromSuperlayer()
        }
        pulseEffect = LFTPulseAnimation(repeatCount: Float.infinity, radius:30, position:childView.center, color: activeColor)
        parentView.layer.insertSublayer(pulseEffect, below: childView.layer)
        pulseEffect.radius = 30
    }

}

