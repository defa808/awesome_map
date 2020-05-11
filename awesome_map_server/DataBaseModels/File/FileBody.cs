using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace DataBaseModels.Models {
    public class FileBody {
        [Key]
        public Guid FileId { get; set; }
        public byte[] Body { get; set; }
        
    }
}
