using System;

namespace DataBaseModels.Models {
    public class Icon {
        public Guid Id { get; set; }
        public int IconCode { get; set; }
        public string FontFamily { get; set; }
        public string FontPackage { get; set; }
    }
}