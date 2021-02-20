package com.company;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import java.io.File;

public class Main {

    public static void main(String[] args) {
	try{
        TransformerFactory tff = TransformerFactory.newInstance();
        Transformer tf = tff.newTransformer(new StreamSource(new File("src/com/company/data/xstlfile.xsl")));
        StreamSource ss = new StreamSource(new File("src/com/company/data/xmlfile.xml"));
        StreamResult sr = new StreamResult(new File("src/com/company/data/htmlfile.html"));
        tf.transform(ss,sr);
        System.out.println("Done");
    }
	catch (Exception e){
        System.out.println(e.getMessage());
    }
    }
}
