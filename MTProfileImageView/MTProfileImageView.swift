//
//  ProfileImageView.swift
//  Salesmate
//
//  Created by Mehul Thakkar on 13/02/19.
//  Copyright © 2019 RapidOps Solution Private Limited. All rights reserved.
//

import UIKit
import SDWebImage


public class MTProfileImageView: UIImageView {
    
    @IBInspectable public var fullName:String?{
        didSet{
            if self.image == nil{
                self.updateUI(withImageUpdate: true);
            }
        }
    }
    
    @IBInspectable public var firstName:String?{
        didSet{
            if self.image == nil{
                self.updateUI(withImageUpdate: true);
            }
        }
    }
    
    @IBInspectable public var lastName:String?{
        didSet{
            if self.image == nil{
                self.updateUI(withImageUpdate: true);
            }
        }
    }
    
    @IBInspectable public var keepSameColorAlwaysForSameName:Bool = true{
        didSet{
            if self.image == nil{
                self.updateUI(withImageUpdate: true);
            }
        }
    }
    
    @IBInspectable public var profileImageURLStr:String?{
        didSet{
            self.image = nil;
            self.updateUI(withImageUpdate: true);
        }
    }
    
    @IBInspectable public var colorCodesArray:[String]?{
        didSet{
            if self.image == nil{
                self.updateUI(withImageUpdate: true);
            }
        }
    }
    
    @IBInspectable public var isRounded:Bool = true{
        didSet{
            self.updateUI(withImageUpdate: true);
        }
    }
    
    public var shortNameLabel:UILabel?
    let colorGenerator = MTColorGenerator();
    
    public override var image: UIImage?{
        didSet{
            if image != nil{
                self.shortNameLabel?.isHidden = true;
                self.backgroundColor = UIColor.clear;
            }else{
                self.updateUI(withImageUpdate: false);
            }
        }
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib();
        self.updateUI(withImageUpdate: true);
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews();
        if isRounded{
            if #available(iOS 11.0, *) {
                self.layer.cornerRadius = self.frame.height/2.0;
            } else {
                let anim = CABasicAnimation(keyPath: "cornerRadius")
                anim.fromValue = self.layer.cornerRadius
                let radius = self.frame.size.width / 2
                anim.toValue = radius
                anim.duration = animationDuration
                self.layer.cornerRadius = radius
                if shortNameLabel != nil{
                    shortNameLabel?.center = self.center;
                }
                self.layer.add(anim, forKey: "cornerRadius")
                animationDuration = 0
            }
        }
    }
    
    func updateUI(withImageUpdate:Bool) {
        
        if shortNameLabel == nil{
            shortNameLabel = UILabel(frame: self.bounds);
        }
        
        let fontSize = self.bounds.size.height/3.0;
        
        shortNameLabel?.textAlignment = .center;
        if #available(iOS 8.2, *) {
            shortNameLabel?.font = UIFont.systemFont(ofSize: fontSize, weight: UIFont.Weight.medium)
        } else {
            shortNameLabel?.font = UIFont.boldSystemFont(ofSize: fontSize);
        };
        shortNameLabel?.isHidden = false;
        shortNameLabel?.textColor = UIColor.white;
        
        if !self.subviews.contains(shortNameLabel!){
            self.addSubview(shortNameLabel!);
            shortNameLabel?.translatesAutoresizingMaskIntoConstraints = false;
            if #available(iOS 9.0, *) {
                shortNameLabel!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true;
                shortNameLabel!.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true;
            } else {
                // Fallback on earlier versions
            };
        }
        
        colorGenerator.keepSameColorAlwaysForSameName = self.keepSameColorAlwaysForSameName;
        
        if self.colorCodesArray != nil{
            colorGenerator.colorCodesForProfilePicBG = self.colorCodesArray!;
        }
        
        self.backgroundColor = colorGenerator.getRandomBgColor(forName: fullName ?? "\(firstName ?? "") \(lastName ?? "")");
        
        if firstName != nil && lastName != nil && !firstName!.trim().isEmpty && !lastName!.trim().isEmpty{
            self.shortNameLabel?.text = "\(firstName!.prefix(1).uppercased())\(lastName!.prefix(1).uppercased())"
        }else{
            if fullName == nil{
                fullName = "\(firstName ?? "") \(lastName ?? "")";
            }
            
            self.shortNameLabel?.text = self.getShort2CharStringFromFullNameString(fullNameStr: fullName!);
        }
        
        
        if withImageUpdate{
            if profileImageURLStr != nil, !profileImageURLStr!.isEmpty, let profileImageURL = URL(string: profileImageURLStr!){
                self.sd_setImage(with: profileImageURL) { (image, _, _, _) in
                    if image != nil{
                        self.image = image;
                        self.shortNameLabel?.isHidden = true;
                    }else{
                        self.shortNameLabel?.isHidden = false;
                    }
                }
            }
        }
        
        if isRounded{
            self.layer.cornerRadius = self.bounds.size.width/2.0;
            self.layer.masksToBounds = true;
        }
    }
    
    private func getShort2CharStringFromFullNameString(fullNameStr:String) -> String {
        let query = fullNameStr.trim();
        
        if !query.isEmpty {
            let separators = CharacterSet(charactersIn: "-_(.,[{:;@# ")
            
            var strComponents:Array = query.components(separatedBy: separators)
            
            if strComponents.contains("-") {
                strComponents.remove(at: strComponents.firstIndex(of: "-")!)
            }
            
            if strComponents.contains(" ") {
                strComponents.remove(at: strComponents.firstIndex(of: " ")!)
            }
            
            if strComponents.contains("") {
                strComponents.remove(at: strComponents.firstIndex(of: "")!)
            }
            
            if strComponents.count > 2 {
                strComponents.removeLast()
            }
            
            if (strComponents.count == 1) { //Single component case, take characters from only that component only
                let titleStr = strComponents[0];
                var finalStr:String = "";
                
                if titleStr.count > 1 {
                    finalStr = String(titleStr.prefix(2)); // Take first 2 characters
                }else if titleStr.count > 0{
                    finalStr = String(titleStr.prefix(1)); // Take single character
                }
                
                return finalStr.uppercased()
            } else {  // Multiple component case, take first characters of first 2 components and join them
                
                var finalStr = "";
                
                //Creating string by taking first char of all components
                for component in strComponents {
                    if !component.isEmpty {
                        let firstCharStr = String(component.prefix(1));
                        finalStr = "\(finalStr)\(firstCharStr)"
                    }
                }
                
                if finalStr.count > 1 {
                    return String(finalStr.prefix(2)).uppercased();
                } else if finalStr.count > 0 {
                    return String(finalStr.prefix(1)).uppercased();
                }else{
                    return "";
                }
            }
        } else {
            return ""
        }
    }
}


extension String{
    fileprivate func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}


class MTColorGenerator: NSObject {
    
    var keepSameColorAlwaysForSameName:Bool = true;
    var colorCodesForProfilePicBG = [
        "255,86,34",
        "128,87,255",
        "77,136,255",
        "255,65,105",
        "103,58,183",
        "3,169,244",
        "38,197,218",
        "0,172,124",
        "192,202,51",
        "255,178,1",
        "0,204,136"
    ]
//    var colorCodesForProfilePicBG = [
//        "239,154,154",
//        "0,191,165",
//        "255,138,101",
//        "149,117,205",
//        "244,143,177",
//        "129,199,132",
//        "188,170,164",
//        "92,107,192",
//        "206,147,216",
//        "174,213,129",
//        "189,189,189",
//        "100,181,246",
//        "179,157,219",
//        "212,225,87",
//        "176,190,197",
//        "0,229,255",
//        "158,167,217",
//        "253,216,53",
//        "255,138,128",
//        "29,233,182",
//        "143,201,248",
//        "255,193,7",
//        "255,128,171",
//        "127,221,233",
//        "255,183,77",
//        "186,104,200"];
    
    func getRandomBgColor(forName profileName:String) -> UIColor{
        
        var index = Int.random(in: 0..<colorCodesForProfilePicBG.count)
        
        if keepSameColorAlwaysForSameName {
            var totalValue: Int = 0;
            for character in profileName.utf8 {
                let stringSegment = "\(character)"
                let intValue = Int(stringSegment)!;
                totalValue = totalValue + intValue;
            }
            index = totalValue % colorCodesForProfilePicBG.count
        }
        
        let selectedColorStr = colorCodesForProfilePicBG[index];
        let colorsArray = selectedColorStr.components(separatedBy: ",").map { CGFloat(Double($0)!)}
        let selectedColor = UIColor(red: colorsArray[0]/255.0, green: colorsArray[1]/255.0, blue: colorsArray[2]/255.0, alpha: 1.0);
        return selectedColor;
    }
}
