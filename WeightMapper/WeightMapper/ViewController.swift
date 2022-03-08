//
//  ViewController.swift
//  WeightMapper
//
//  Created by Karteikay Dhuper on 3/4/22.
//

import UIKit
import Charts

class ViewController: UIViewController
{

    @IBOutlet weak var weightView: LineChartView!
    
    @IBAction func weightEntry(_ sender: UITextField) {
       // data.append(weightEntry.text)

    }
    @IBOutlet weak var weightEntry: UITextField!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let data = [96,93,94,91,90,88,85]
        graphLineChart(dataArray: data)
        
        //Call it in viewDidLoad

        addDoneButtonOnNumpad(textField:weightEntry)

        func addDoneButtonOnNumpad(textField: UITextField)
        {
                let keypadToolbar: UIToolbar = UIToolbar()

                // add a done button to the numberpad
                keypadToolbar.items=[
                    UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: textField, action: #selector(UITextField.resignFirstResponder)),
                    UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
                ]
                keypadToolbar.sizeToFit()
                // add a toolbar with a done button above the number pad
                textField.inputAccessoryView = keypadToolbar
            }//addDoneToKeyPad
    }
    
    // function to convert text entry value to number
    func textToInteger(from weightEntry: UITextField ) -> Int
    {
        guard let text = weightEntry.text,
              let weight = Int(text)
        else
        {
            return 0
        }
        return weight
        //let newWeight = weightEntry
        
    }
    
//    saves new weight data to data array
//    func saveNewWeight(textToInteger: Int)
//    {
//        let data = data.append(textToInteger(from: weightEntry))
//    }

    func graphLineChart(dataArray: [Int])
    {
        weightView.frame = CGRect(x:0, y:0,
                                    width: self.view.frame.size.width,
                                    height:self.view.frame.size.width/2)

        weightView.center.x = self.view.center.x
        weightView.center.y = self.view.center.y - 240

        // settings when chart has no data
        weightView.noDataText = "No data available"
        weightView.noDataTextColor = UIColor.black

        // initialize array that will be displayed on the graph
        var entries = [ChartDataEntry]()

        //For every element in a given data set
        //Set

        for i in 0...dataArray.count-1
        {
            let value = ChartDataEntry(x: Double(i), y:Double(dataArray[i]) )
            entries.append(value)
        }

        // use the entries object and a label string to make a LineChartDataSet object
        let dataSet = LineChartDataSet(entries: entries, label: "Line Chart")

        dataSet.setCircleColor(UIColor.green)
        dataSet.valueFont = UIFont(name: "Arial", size: 15)!

        // customize graph settings to your liking
        dataSet.colors = ChartColorTemplates.pastel()

        // make objects that will be added to the chart
        // and set it to the variable in the Storyboard
        let data = LineChartData(dataSet: dataSet)
        weightView.data = data

        //description
        weightView.chartDescription?.text = "Line Chart"

        //animations
        weightView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0, easingOption: .linear)

    }
    

}

