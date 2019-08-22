//
//  ViewController.swift
//  KeyModel
//
//  Created by Brandon Huss on 7/6/19.
//  Copyright © 2019 UCSC_CS115. All rights reserved.
//

import UIKit
import AudioKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    ///////////////
    ////Outlets////
    ///////////////
    
    // Outlets for keys
    @IBOutlet weak var C: UIButton!                 //0
    @IBOutlet weak var CD: UIButton!                //1
    @IBOutlet weak var D: UIButton!                 //2
    @IBOutlet weak var DE: UIButton!                //3
    @IBOutlet weak var E: UIButton!                 //4
    @IBOutlet weak var F: UIButton!                 //5
    @IBOutlet weak var FG: UIButton!                //6
    @IBOutlet weak var G: UIButton!                 //7
    @IBOutlet weak var GA: UIButton!                //8
    @IBOutlet weak var A: UIButton!                 //9
    @IBOutlet weak var AB: UIButton!                //10
    @IBOutlet weak var B: UIButton!                 //11
    
    // Switch to lock current scale
    @IBOutlet weak var scaleLockSwitch: UISwitch!
    
    // Button to reset current scale and colors
    @IBOutlet weak var resetButton: UIButton!       
      
    // Selected scale
    @IBOutlet weak var select: UILabel!
    
    // "Selected Scale" label
    @IBOutlet weak var selectedLabel: UILabel!
    
    // Methods for scale picker menu
    @IBOutlet weak var pickerView: UIPickerView!
    
    //////////////////////
    ////Initial Values////
    //////////////////////
    
    // Array of scales for picker menu
    let scales = ["Ionian", "Dorian", "Phrygian", "Lydian", "Mixolydian", "Aeolian", "Locrian", "Chromatic", "Major Pentatonic", "Minor Pentatonic", "Major Blues", "Minor Blues", "Whole Tone", "Harmonic Minor", "Melodic Minor", "Altered", "Bebop", "Whole-Half", "Half-Whole"]
  
    // Methods for sound
    let soundGenerator = SoundGenerator()
    
    //Initial scale is Ionian, key center is not set
    var scale: String = "Ionian"    
    var key: String = ""     
    
    //Initial scale lock status is false
    var scaleLocked = false
    
    ///////////////////
    ////Picker View////
    ///////////////////   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return scales[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return scales.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        scale = scales[row]
        select.text = scales[row]
        if scaleLocked {
            ModifyKeys(key: key, scale: scale)
        }
    }
    
    // Change colors of picker text to contrast with background
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        selectedLabel.textColor = UIColor.white
        let scaleData = scales[row]
        let scaleText = NSAttributedString(string: scaleData, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        return scaleText
    }
    
    //////////////////
    ////Scale Lock////
    //////////////////       
    
    // To toggle current Lock State
    @IBAction func ChangeScaleLockState(){     
        if scaleLocked{                        //If scale locked before,
            scaleLocked = false                //do unlock
        }else{                                  //If scale unlocked
            scaleLocked = true                 //do lock
            ModifyKeys(key: key, scale: scale)  //and set current scale. 
        }
    }
    
    // Unlock scale and change button image
    func UnlockScale(){
        scaleLocked = false                            //Unlock scale
        scaleLockSwitch.setOn(false, animated: true)    //Unlock button
    }
    
    ////////////////////////
    ////Scale Implements////
    ////////////////////////
    
    //Major scale
    func Major(root: Int){
        ColorKey(num: root)     //Root
        ColorKey(num: root+2)   //Major 2nd
        ColorKey(num: root+4)   //Major 3rd
        ColorKey(num: root+5)   //Perfect 4th
        ColorKey(num: root+7)   //Perfect 5th
        ColorKey(num: root+9)   //Major 6th
        ColorKey(num: root+11)  //Major 7th
    }
    
    //Pentatonic scale
    func Pentatonic(root: Int){
        ColorKey(num: root)     //Root
        ColorKey(num: root+2)   //Major 2nd
        ColorKey(num: root+4)   //Major 3rd
        ColorKey(num: root+7)   //Perfect 5th
        ColorKey(num: root+9)   //Major 6th
    }
    
    //Blues scale
    func Blues(root: Int){
        ColorKey(num: root)     //Root
        ColorKey(num: root+2)   //Major 2nd
        ColorKey(num: root+3)   //Minor 3rd
        ColorKey(num: root+4)   //Major 3rd
        ColorKey(num: root+7)   //Perfect 5th
        ColorKey(num: root+9)   //Major 6th
    }
    
    //Chromatic scale
    func Chromatic(){
        ColorKey(num: 0)        //C
        ColorKey(num: 1)        //C#
        ColorKey(num: 2)        //D
        ColorKey(num: 3)        //D#
        ColorKey(num: 4)        //E
        ColorKey(num: 5)        //F
        ColorKey(num: 6)        //F#
        ColorKey(num: 7)        //G
        ColorKey(num: 8)        //G#
        ColorKey(num: 9)        //A
        ColorKey(num: 10)       //A#
        ColorKey(num: 11)       //B
    }
    
    //Whole tone scale 
    func WholeTone(root: Int){
        ColorKey(num: root)     //Root
        ColorKey(num: root+2)   //Major 2nd
        ColorKey(num: root+4)   //Major 3rd
        ColorKey(num: root+6)   //Augmented 4th
        ColorKey(num: root+8)   //Augmented 5th
        ColorKey(num: root+10)  //Augmented 6th
    }
    
    //Harmonic minor scale
    func Harmonic(root: Int){
        ColorKey(num: root)     //Root
        ColorKey(num: root+2)   //Major 2nd
        ColorKey(num: root+3)   //Minor 3rd
        ColorKey(num: root+5)   //Perfect 4th
        ColorKey(num: root+7)   //Perfet 5th
        ColorKey(num: root+8)   //Minor 6th
        ColorKey(num: root+11)  //Major 7th
    }
    
    //Melodic minor scale
    func Melodic(root: Int){
        ColorKey(num: root)     //Root
        ColorKey(num: root+2)   //Major 2nd
        ColorKey(num: root+3)   //Minor 3rd
        ColorKey(num: root+5)   //Perfect 4th
        ColorKey(num: root+7)   //Perfect 5th
        ColorKey(num: root+9)   //Major 6th
        ColorKey(num: root+11)  //Major 7th
    }
    
    //Altered scale
    func Altered(root: Int){
        ColorKey(num: root)     //Root
        ColorKey(num: root+1)   //Minor 2nd
        ColorKey(num: root+3)   //Minor 3rd
        ColorKey(num: root+4)   //Diminished 4th
        ColorKey(num: root+6)   //Diminished 5th
        ColorKey(num: root+8)   //Minor 6th
        ColorKey(num: root+10)  //Minor 7th
    }
    
    //Bebop scale
    func Bebop(root: Int){
        ColorKey(num: root)     //Root
        ColorKey(num: root+2)   //Major 2nd
        ColorKey(num: root+4)   //Major 3rd
        ColorKey(num: root+5)   //Perfect 4th
        ColorKey(num: root+7)   //Perfect 5th
        ColorKey(num: root+9)   //Major 6th
        ColorKey(num: root+10)  //Minor 7th
        ColorKey(num: root+11)  //Major 7th
    }
    
    //Whole-half scale
    func WholeHalf(root: Int){
        ColorKey(num: root)     //Root
        ColorKey(num: root+2)   //Major 2nd
        ColorKey(num: root+3)   //Minor 3rd
        ColorKey(num: root+5)   //Perfect 4th
        ColorKey(num: root+6)   //Diminished 5th
        ColorKey(num: root+8)   //Minor 6th
        ColorKey(num: root+9)   //Major 6th
        ColorKey(num: root+11)  //Major 7th
    }
    
    //Half-whole scale
    func HalfWhole(root: Int){
        ColorKey(num: root)     //Root
        ColorKey(num: root+1)   //Minor 2nd
        ColorKey(num: root+3)   //Minor 3rd
        ColorKey(num: root+4)   //Major 3rd
        ColorKey(num: root+6)   //Augmented 4th
        ColorKey(num: root+7)   //Perfect 5th
        ColorKey(num: root+9)   //Major 6th
        ColorKey(num: root+10)  //Minor 7th
    }

    // Methods for modifying displayed scale
    func ScaleType(root: Int){
        if scale == "Ionian" {              //Ionian is the 1st mode of a major scale.
            Major(root: root)
        }else if scale == "Dorian"{
            Major(root: root-2)             //Dorian is the 2nd mode of a major scale.
        }else if scale == "Phrygian"{
            Major(root: root-4)             //Phrygian is the 3rd mode of a major scale.
        }else if scale == "Lydian"{
            Major(root: root-5)             //Lydian is the 4th mode of a major scale.
        }else if scale == "Mixolydian"{
            Major(root: root-7)             //Mixolydian is the 5th mode of a major scale.
        }else if scale == "Aeolian"{
            Major(root: root-9)             //Aeolian is the 6th mode of a major scale.
        }else if scale == "Locrian"{
            Major(root: root-11)            //Locrian is the 7th mode of a major scale.
        }else if scale == "Chromatic"{
            Chromatic()                     //Chromatic is all 12 tones.
        }else if scale == "Major Pentatonic"{
            Pentatonic(root: root)          //Major Pentatonic is the 1st mode of a pentatonic scale. 
        }else if scale == "Minor Pentatonic"{
            Pentatonic(root: root-9)        //Minor Pentatonic is the 5th mode of a pentatonic scale.
        }else if scale == "Major Blues"{
            Blues(root: root)               //Major Blues is the 1st mode of a blues scale.
        }else if scale == "Minor Blues"{
            Blues(root: root-9)             //Minor Blues is the 6th mode of a blues scale.
        }else if scale == "Whole Tone"{
            WholeTone(root: root)           //Whole tone is the 1st mode of a whole tone scale.
        }else if scale == "Harmonic Minor"{
            Harmonic(root: root)            //Harmonic minor is the 1st mode of a harmonic minor scale.
        }else if scale == "Melodic Minor"{
            Melodic(root: root)             //Melodic minor is the 1st mode of a melodic minor scale.
        }else if scale == "Altered"{
            Altered(root: root)             //Altered is the 1st mode of a altered scale.
        }else if scale == "Bebop"{
            Bebop(root: root)               //Bebop is the 1st mode of a bebop scale.
        }else if scale == "Whole-Half"{
            WholeHalf(root: root)           //Whole-half is the 1st mode of a whole-half scale.
        }else if scale == "Half-Whole"{
            HalfWhole(root: root)           //Half-whole is the 1st mode of a half-whole scale.
        }
    }
    
    //////////////////
    ///Key Controls///
    //////////////////
    
    //Colors keys based on selected scale
    func ColorKey(num: Int){
        switch num {
        case -12,0,12:                                  //if 0 (mod 12)
            C.backgroundColor = UIColor.lightGray       //Color C
        case -11,1,13:                                  //if 1 (mod 12)
            CD.backgroundColor = UIColor.lightGray      //Color C#
        case -10,2,14:                                  //if 2 (mod 12)
            D.backgroundColor = UIColor.lightGray       //Color D
        case -9,3,15:                                   //if 3 (mod 12)
            DE.backgroundColor = UIColor.lightGray      //Color D#
        case -8,4,16:                                   //if 4 (mod 12)
            E.backgroundColor = UIColor.lightGray       //Color E
        case -7,5,17:                                   //if 5 (mod 12)
            F.backgroundColor = UIColor.lightGray       //Color F
        case -6,6,18:                                   //if 6 (mod 12)
            FG.backgroundColor = UIColor.lightGray      //Color F#
        case -5,7,19:                                   //if 7 (mod 12)
            G.backgroundColor = UIColor.lightGray       //Color G
        case -4,8,20:                                   //if 8 (mod 12)
            GA.backgroundColor = UIColor.lightGray      //Color G#
        case -3,9,21:                                   //if 9 (mod 12)
            A.backgroundColor = UIColor.lightGray       //Color A
        case -2,10,22:                                  //if 10 (mod 12)
            AB.backgroundColor = UIColor.lightGray      //Color A#
        case -1,11,23:                                  //if 11 (mod 12)
            B.backgroundColor = UIColor.lightGray       //Color B

        default:                                    //if none is selected
            C.backgroundColor = UIColor.white       //C is white
            CD.backgroundColor = UIColor.darkText   //C# is black
            D.backgroundColor = UIColor.white       //D is white
            DE.backgroundColor = UIColor.darkText   //D# is black
            E.backgroundColor = UIColor.white       //E is white
            F.backgroundColor = UIColor.white       //F is white  
            FG.backgroundColor = UIColor.darkText   //F# is black
            G.backgroundColor = UIColor.white       //G is white
            GA.backgroundColor = UIColor.darkText   //G# is black
            A.backgroundColor = UIColor.white       //A is white
            AB.backgroundColor = UIColor.darkText   //A# is black
            B.backgroundColor = UIColor.white       //B is white
        }
    }
   
    //Press C
    @IBAction func CPress(_ sender: Any) {
        key = "C"                               //Set Key Center to C
        if !scaleLocked {                      //If scale is not locked,
            ModifyKeys(key: key, scale: scale)  //set new key center.
        }
        soundGenerator.startOsc(pitch: 261.63)            //Start ringing sound, C = 261.63Hz
    }
    
    //Press C#
    @IBAction func CDPress(_ sender: Any) {
        key = "C#/Db"                           //Set Key Center to C#
        if !scaleLocked {                      //If scale is not locked,
            ModifyKeys(key: key, scale: scale)  //set new key center.
        }
        soundGenerator.startOsc(pitch: 277.18)            //Start ringing sound, C# = 277.18Hz
    }
    
    //Press D
    @IBAction func DPress(_ sender: Any) {
        key = "D"                               //Set Key Center to D
        if !scaleLocked {                      //If scale is not locked,
            ModifyKeys(key: key, scale: scale)  //set new key center.
        }
        soundGenerator.startOsc(pitch: 293.66)            //Start ringing sound, D = 293.66Hz
    }
    
    //Press D#
    @IBAction func DEPress(_ sender: Any) {
        key = "D#/Eb"                           //Set Key Center to D#
        if !scaleLocked {                      //If scale is not locked,
            ModifyKeys(key: key, scale: scale)  //set new key center.
        }
        soundGenerator.startOsc(pitch: 311.13)            //Start ringing sound, D# = 311.13Hz
    }
    
    //Press E
    @IBAction func EPress(_ sender: Any) {
        key = "E"                               //Set Key Center to E
        if !scaleLocked {                      //If scale is not locked,
            ModifyKeys(key: key, scale: scale)  //set new key center.
        }
        soundGenerator.startOsc(pitch: 329.63)            //Start ringing sound, E = 329.63Hz
    }
    
    //Press F
    @IBAction func FPress(_ sender: Any) {
        key = "F"                               //Set Key Center to F
        if !scaleLocked {                      //If scale is not locked,
            ModifyKeys(key: key, scale: scale)  //set new key center.
        }
        soundGenerator.startOsc(pitch: 349.23)            //Start ringing sound, E = 349.23Hz
    }
    
    //Press F#
    @IBAction func FGPress(_ sender: Any) {
        key = "F#/Gb"                           //Set Key Center to F#
        if !scaleLocked {                      //If scale is not locked,
            ModifyKeys(key: key, scale: scale)  //set new key center.
        }   
        soundGenerator.startOsc(pitch: 369.99)            //Start ringing sound, F# = 369.99Hz
    }
    
    //Press G
    @IBAction func GPress(_ sender: Any) {
        key = "G"                               //Set Key Center to G
        if !scaleLocked {                      //If scale is not locked,
            ModifyKeys(key: key, scale: scale)  //set new key center.
        }
        soundGenerator.startOsc(pitch: 392.0)             //Start ringing sound, G = 392.0Hz
    }
    
    //Press G#
    @IBAction func GAPress(_ sender: Any) {
        key = "G#/Ab"                           //Set Key Center to G#
        if !scaleLocked {                      //If scale is not locked,
            ModifyKeys(key: key, scale: scale)  //set new key center.
        }
        soundGenerator.startOsc(pitch: 415.30)            //Start ringing sound, G# = 415.30Hz
    }
    
    //Press A
    @IBAction func APress(_ sender: Any) {
        key = "A"                               //Set Key Center to A
        if !scaleLocked {                      //If scale is not locked,
            ModifyKeys(key: key, scale: scale)  //set new key center.
        }
        soundGenerator.startOsc(pitch: 440.0)             //Start ringing sound, A = 440.0Hz
    }
    
    //Press A#
    @IBAction func ABPress(_ sender: Any) {
        key = "A#/Bb"                           //Set Key Center to A#
        if !scaleLocked {                      //If scale is not locked,
            ModifyKeys(key: key, scale: scale)  //set new key center.
        }
        soundGenerator.startOsc(pitch: 466.16)            //Start ringing sound, A# = 466.16Hz
    }
    
    //Press B
    @IBAction func BPress(_ sender: Any) {
        key = "B"                               //Set Key Center to B
        if !scaleLocked {                      //If scale is not locked,
            ModifyKeys(key: key, scale: scale)  //set new key center.
        }
        soundGenerator.startOsc(pitch: 493.88)            //Start ringing sound, A# = 493.88Hz
    }
    
    //Key Button Release
    @IBAction func KeyRelease(_ sender: UIButton){
        soundGenerator.stopOsc()                          //Stop sound
        if !scaleLocked {                      //If scale is not locked
            ResetKeyColor()                     //clean all keyboard colors.
        }
    }
    
    // Changes keyboard color based on selected scale
    func ModifyKeys(key: String, scale: String){      
        select.text = key+" "+scale                 //Show current scale
        ColorKey(num: -999)                         //Reset color setting of keys
        if key == "C"{                              //If C is key
            ScaleType(root: 0)                      //C is now root
            C.backgroundColor = UIColor.darkGray    //color C into darkGray
        }else if key == "C#/Db" {                   //If C# is key
            ScaleType(root: 1)                      //C# is now root
            CD.backgroundColor = UIColor.darkGray   //color C# into darkGray
        }else if key == "D" {                       //If D is key
            ScaleType(root: 2)                      //D is now root
            D.backgroundColor = UIColor.darkGray    //color D into darkGray
        }else if key == "D#/Eb" {                   //If D# is key
            ScaleType(root: 3)                      //D# is now root
            DE.backgroundColor = UIColor.darkGray   //color D# into darkGray
        }else if key == "E" {                       //If E is key
            ScaleType(root: 4)                      //E is now root
            E.backgroundColor = UIColor.darkGray    //color E into darkGray
        }else if key == "F" {                       //If F is key
            ScaleType(root: 5)                      //F is now rgroot
            F.backgroundColor = UIColor.darkGray    //color F into darkGray
        }else if key == "F#/Gb" {                   //If F# is key
            ScaleType(root: 6)                      //F# is now root
            FG.backgroundColor = UIColor.darkGray   //color F# into darkGray
        }else if key == "G" {                       //If G is key
            ScaleType(root: 7)                      //G is now root
            G.backgroundColor = UIColor.darkGray    //color G into darkGray
        }else if key == "G#/Ab" {                   //If G# is key
            ScaleType(root: 8)                      //G# is now root
            GA.backgroundColor = UIColor.darkGray   //color G# into darkGray
        }else if key == "A" {                       //If A is key
            ScaleType(root: 9)                      //A is now root
            A.backgroundColor = UIColor.darkGray    //color A into darkGray
        }else if key == "A#/Bb" {                   //If A# is key
            ScaleType(root: 10)                     //A# is now root
            AB.backgroundColor = UIColor.darkGray   //color A# into darkGray
        }else if key == "B" {                       //If B is key
            ScaleType(root: 11)                     //B is now root
            B.backgroundColor = UIColor.darkGray    //color B into darkGray
        }
    }
    
    
    //////////////////////////////////
    //////Reset to Initial State//////
    //////////////////////////////////   
    
    // Resets keyboard to default state
    @IBAction func Reset(_ sender: UIButton) {
        select.text = "<none selected>"         //reset selected scales
        ResetKeyColor()                         //reset key colors
        UnlockScale()                           //reset lock status
    }
    
    //Reset colors of keys to initial state
    func ResetKeyColor(){
        ColorKey(num: -999)                     //Reset colors to original key color
    }
    
    //////////////////////
    //////View Setup//////
    //////////////////////   

    //Setting up UI
    override func viewDidLoad() {
        super.viewDidLoad()
        ResetKeyColor()
        scaleLockSwitch.setOn(false,animated: false)
        AssignBackground()
        AssignButtonShadow()
        CD.titleLabel?.minimumScaleFactor = 0.20;
        CD.titleLabel?.adjustsFontSizeToFitWidth = true;
        DE.titleLabel?.minimumScaleFactor = 0.20;
        DE.titleLabel?.adjustsFontSizeToFitWidth = true;
        FG.titleLabel?.minimumScaleFactor = 0.20;
        FG.titleLabel?.adjustsFontSizeToFitWidth = true;
        GA.titleLabel?.minimumScaleFactor = 0.20;
        GA.titleLabel?.adjustsFontSizeToFitWidth = true;
        AB.titleLabel?.minimumScaleFactor = 0.20;
        AB.titleLabel?.adjustsFontSizeToFitWidth = true;
        resetButton.titleLabel?.minimumScaleFactor = 0.20;
        resetButton.titleLabel?.adjustsFontSizeToFitWidth = true;
    }
    
    //Give shade to buttons
    func AssignButtonShadow(){
        
        C.layer.shadowColor = UIColor.gray.cgColor
        C.layer.shadowOffset =  CGSize(width: 0.0, height: 2.0)
        C.layer.shadowOpacity = 1.0
        
        CD.layer.shadowColor = UIColor.gray.cgColor
        CD.layer.shadowOffset =  CGSize(width: 0.0, height: 2.0)
        CD.layer.shadowOpacity = 1.0
        
        D.layer.shadowColor = UIColor.gray.cgColor
        D.layer.shadowOffset =  CGSize(width: 0.0, height: 2.0)
        D.layer.shadowOpacity = 1.0
        
        DE.layer.shadowColor = UIColor.gray.cgColor
        DE.layer.shadowOffset =  CGSize(width: 0.0, height: 2.0)
        DE.layer.shadowOpacity = 1.0
        
        E.layer.shadowColor = UIColor.gray.cgColor
        E.layer.shadowOffset =  CGSize(width: 0.0, height: 2.0)
        E.layer.shadowOpacity = 1.0
        
        F.layer.shadowColor = UIColor.gray.cgColor
        F.layer.shadowOffset =  CGSize(width: 0.0, height: 2.0)
        F.layer.shadowOpacity = 1.0
        
        FG.layer.shadowColor = UIColor.gray.cgColor
        FG.layer.shadowOffset =  CGSize(width: 0.0, height: 2.0)
        FG.layer.shadowOpacity = 1.0
        
        G.layer.shadowColor = UIColor.gray.cgColor
        G.layer.shadowOffset =  CGSize(width: 0.0, height: 2.0)
        G.layer.shadowOpacity = 1.0
        
        GA.layer.shadowColor = UIColor.gray.cgColor
        GA.layer.shadowOffset =  CGSize(width: 0.0, height: 2.0)
        GA.layer.shadowOpacity = 1.0
        
        A.layer.shadowColor = UIColor.gray.cgColor
        A.layer.shadowOffset =  CGSize(width: 0.0, height: 2.0)
        A.layer.shadowOpacity = 1.0
        
        AB.layer.shadowColor = UIColor.gray.cgColor
        AB.layer.shadowOffset =  CGSize(width: 0.0, height: 2.0)
        AB.layer.shadowOpacity = 1.0
        
        B.layer.shadowColor = UIColor.gray.cgColor
        B.layer.shadowOffset =  CGSize(width: 0.0, height: 2.0)
        B.layer.shadowOpacity = 1.0
    }
    
    //Set background
    func AssignBackground(){
        let background = UIImage(named: "space.jpg")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
}

