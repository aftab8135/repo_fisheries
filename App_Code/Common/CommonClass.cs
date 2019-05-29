using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Reflection;
using System.Web.Script.Serialization;
using System.IO;
using System.Xml.Serialization;

public class CommonClass
{

    public static DataTable ToDataTable<T>(List<T> items)
    {
        DataTable dataTable = new DataTable(typeof(T).Name);

        //Get all the properties
        PropertyInfo[] Props = typeof(T).GetProperties(BindingFlags.Public | BindingFlags.Instance);
        foreach (PropertyInfo prop in Props)
        {
            //Defining type of data column gives proper data table 
            var type = (prop.PropertyType.IsGenericType && prop.PropertyType.GetGenericTypeDefinition() == typeof(Nullable<>) ? Nullable.GetUnderlyingType(prop.PropertyType) : prop.PropertyType);
            //Setting column names as Property names
            dataTable.Columns.Add(prop.Name, type);
        }
        foreach (T item in items)
        {
            var values = new object[Props.Length];
            for (int i = 0; i < Props.Length; i++)
            {
                //inserting property values to datatable rows
                values[i] = Props[i].GetValue(item, null);
            }
            dataTable.Rows.Add(values);
        }
        //put a breakpoint here and check datatable
        return dataTable;
    }

    public static string DataSetToJSON(DataTable dt)
    {

        Dictionary<string, object> dict = new Dictionary<string, object>();
        //foreach (DataTable dt in ds.Tables)
        //{
        object[] arr = new object[dt.Rows.Count + 1];

        for (int i = 0; i <= dt.Rows.Count - 1; i++)
        {
            arr[i] = dt.Rows[i].ItemArray;
        }

        dict.Add(dt.TableName, arr);
        //}

        JavaScriptSerializer json = new JavaScriptSerializer();
        return json.Serialize(dict);
    }


    public static string GetNewFileName(string flName, string ext, string key)
    {
        string str = "";
        int index = flName.LastIndexOf('.');
        str = index == -1 ? flName : flName.Substring(0, index);
        str = str.Replace(" ", "_") + "_" + key + ext;
        return str;

    }


    public static string ConvertObjectToXML(object dataToSerialize)
    {
        if (dataToSerialize == null) return null;

        using (StringWriter stringwriter = new System.IO.StringWriter())
        {
            var serializer = new XmlSerializer(dataToSerialize.GetType());
            serializer.Serialize(stringwriter, dataToSerialize);
            return stringwriter.ToString();
        }
    }

    public static T ConvertXMLToObject<T>(string xmlText)
    {
        if (String.IsNullOrWhiteSpace(xmlText)) return default(T);

        using (StringReader stringReader = new System.IO.StringReader(xmlText))
        {
            var serializer = new XmlSerializer(typeof(T));
            return (T)serializer.Deserialize(stringReader);
        }
    }
}