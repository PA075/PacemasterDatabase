using PharmaACE.ForecastApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;

using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;
using System.Xml;
using System.IO;

namespace PharmaACE.ForecastApp.Business
{
    
    public interface ParserIFactory
    {        string Parsing(byte[] fileContent,  string filterKeyword); 

    }
    public class XMLType : ParserIFactory
    {
        public string Parsing(byte[] fileContent, string filterKeyword)
        {
            string containedLine = string.Empty;
            try
            {
                const string wordmlNamespace = "http://schemas.openxmlformats.org/wordprocessingml/2006/main";

                string textBuilder = "";

                using (MemoryStream mem = new MemoryStream())
                {
                    mem.Write(fileContent, 0, (int)(fileContent).Length);

                    using (WordprocessingDocument wdDoc = WordprocessingDocument.Open(mem, true))
                    {
                        // Manage namespaces to perform XPath queries.  
                        NameTable nt = new NameTable();
                        XmlNamespaceManager nsManager = new XmlNamespaceManager(nt);
                        nsManager.AddNamespace("w", wordmlNamespace);

                        // Get the document part from the package.  
                        // Load the XML in the document part into an XmlDocument instance.  
                        XmlDocument xdoc = new XmlDocument(nt);
                        xdoc.Load(wdDoc.MainDocumentPart.GetStream());

                        XmlNodeList paragraphNodes = xdoc.SelectNodes("//w:p", nsManager);
                        foreach (XmlNode paragraphNode in paragraphNodes)
                        {
                            XmlNodeList textNodes = paragraphNode.SelectNodes(".//w:t", nsManager);
                            foreach (System.Xml.XmlNode textNode in textNodes)
                            {
                                textBuilder = textBuilder + textNode.InnerText;                               
                            }
                            textBuilder += Environment.NewLine;                            
                        }
                    }
                }
                if (!string.IsNullOrEmpty(textBuilder))
                {
                    // Regex r = new Regex("(?i)([^\r\n])+[\r\n].*" + filterKeyword + ".*[\r\n]+([^\r\n]+)");
                    Regex r = new Regex("(?i).*" + filterKeyword + ".*[\r\n]+([^\r\n]+)");

                    var word = r.Match(textBuilder);
                    containedLine = word.Value;
                }
            }
            catch (Exception ex)
            {
                containedLine = "";      
            }
            return containedLine;
        }

    }

    public class PDFType : ParserIFactory
    {
        public string Parsing(byte[] fileContent,  string filterKeyword)
        {
            string containedLine = string.Empty;
            string pdfWholeFileText = string.Empty;

            try
            {
                var oReader = new iTextSharp.text.pdf.PdfReader(fileContent);
                for (int j = 1; j <= oReader.NumberOfPages; j++)
                {
                    var its = new iTextSharp.text.pdf.parser.SimpleTextExtractionStrategy();
                    pdfWholeFileText += iTextSharp.text.pdf.parser.PdfTextExtractor.GetTextFromPage(oReader, j, its);
                }
                if (!string.IsNullOrEmpty(pdfWholeFileText))
                {

                    Regex r = new Regex("(?i).*" + filterKeyword + ".*[\r\n]+([^\r\n]+)");
                    var word = r.Match(pdfWholeFileText);
                    containedLine = word.Value;
                }

            }
            catch (Exception ex)
            {
                containedLine = "";

            }

             return containedLine;

        }

    }

    public class TextType : ParserIFactory
    {
        public string Parsing(byte[] fileContent, string filterKeyword)
        {
            string containedLine = string.Empty;
            string WholeFileText = string.Empty;

            try
            {
                WholeFileText = System.Text.Encoding.Default.GetString((byte[])(fileContent));

                if (!string.IsNullOrEmpty(WholeFileText))
                {

                    Regex r = new Regex("(?i).*" + filterKeyword + ".*[\r\n]+([^\r\n]+)");
                    var word = r.Match(WholeFileText);
                    containedLine = word.Value;
                }

            }
            catch (Exception ex)
            {
                containedLine = "";

            }

            return containedLine;

        }

    }

    public abstract class ParserTypeFactory
    {

        public abstract ParserIFactory getParserContentType(ParsersTypes type);
    }

    public class ConcreteParserContentFactory : ParserTypeFactory
    {
        public override ParserIFactory getParserContentType(ParsersTypes type)
        {
            switch (type.ToString())
            {
                case "PDFType":
                    return new PDFType();
                case "XMLType":
                    return new XMLType();
                case "TextType":
                    return new TextType();
                default:
                    throw new ApplicationException(string.Format("StorageType '{0}' cannot be created", type));
            }
        }

    }


}
