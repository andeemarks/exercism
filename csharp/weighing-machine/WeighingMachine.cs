using System;

class WeighingMachine
{
    private string displayWeight;

    public string DisplayWeight
    {
        get
        {
            displayWeight = (this.Weight - this.TareAdjustment).ToString($"F{this.Precision}");
            return $"{displayWeight} kg";
        }
    }
    private double weight;

    public double Weight
    {
        get { return this.weight; }
        set
        {
            if (value < 0)
            {
                throw new ArgumentOutOfRangeException();
            }
            weight = value;
        }
    }

    public WeighingMachine(int precision)
    {
        this.Precision = precision;
    }

    public int Precision { get; }

    public double TareAdjustment { get; set; } = 5;
}
