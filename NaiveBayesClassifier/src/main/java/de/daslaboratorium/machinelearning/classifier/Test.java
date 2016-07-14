package de.daslaboratorium.machinelearning.classifier;

import java.util.Arrays;

import de.daslaboratorium.machinelearning.classifier.bayes.BayesClassifier;

public class Test {
	public static void main(String args[]){
		Classifier<String, String> bayes = new BayesClassifier<String, String>();
		String[] positiveText = "I love sunny days".split("\\s");
		String[] negativeText = "I hate rain".split("\\s");
		bayes.learn("positive", Arrays.asList(positiveText));
		bayes.learn("negative", Arrays.asList(negativeText));
		
		
		String[] unknownText1 = "today is a sunny day  there will be rain".split("\\s");
		String[] unknownText2 = "there will be rain".split("\\s");
		
		System.out.println( // will output "positive"
			    bayes.classify(Arrays.asList(unknownText1)).getCategory());
			System.out.println( // will output "negative"
			    bayes.classify(Arrays.asList(unknownText2)).getCategory());
			
			System.out.println(((BayesClassifier<String, String>) bayes).classifyDetailed(
				    Arrays.asList(unknownText1)));

	}
}
