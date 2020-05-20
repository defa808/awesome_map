using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace DataBaseModels.Models {
    public class FileBody {
        public byte[] Body { get; set; }
        [Key]
        public Guid ServerFileId { get; set; }
        public ServerFile ServerFile { get; set; }
        public string ContentType { get; set; }
    }
}
