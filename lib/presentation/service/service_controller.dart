import 'package:get/get.dart';

class ServiceController extends GetxController{

   var expandedIndex = (-1).obs; // Tracks the currently expanded tile index

  void toggleExpansion(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1; // Collapse if already expanded
    } else {
      expandedIndex.value = index; // Expand the clicked tile
    }
  }

  final services = [
    {
      'title': 'Plagiarism report & Correction',
      'features': [
      {'feature': 'Plagiarism scanning of any document', 'fees': '500 INR (20 USD)', 'time': '1 day'},
      {'feature': 'Removing plagiarism', 'fees': '3500 INR (article)', 'time': '1-2 days'}
      ]
    },
    {
      'title': 'Title suggestion',
      'features': [
      {'feature': 'Novel title based on client\'s interest', 'fees': '2000 INR (40 USD)', 'time': '1-2 days'}
      ]
    },
    {
      'title': 'Proofreading & Paraphrasing',
      'features': [
      {'feature': 'Language, grammar, punctuation, error in sentence, coherence of sentence with proper meaning and writing with certificate of proofreading', 'fees': '3000 INR (95 USD)', 'time': '1-2 days'}
      ]
    },
    {
      'title': 'Powerpoint presentation',
      'features': [
      {'feature': 'Based on thesis or project', 'fees': '2500 INR (95 USD)', 'time': '1-2 days'}
      ]
    },
    {
      'title': 'Statistical analysis',
      'features': [
      {'feature': 'Statistics analysis', 'fees': '2500 INR (95 USD)', 'time': '1-2 days'}
      ]
    },
    {
      'title': 'Mentoring/Guidance',
      'features': [
      {'feature': 'Guidance for performing experiment or research work', 'fees': '5000 INR (120 USD)', 'time': 'Till completion'}
      ]
    },
    {
      'title': 'Synopsis',
      'features': [
      {'feature': 'Introduction, review literature, objective, plan of work and outcome', 'fees': '5000 INR (100 USD)', 'time': '1-2 days'}
      ]
    },
    {
      'title': 'Project Proposal',
      'features': [
      {'feature': 'Research proposal for funding', 'fees': '5000 INR (110 USD)', 'time': '2-3 days'}
      ]
    },
    {
      'title': 'Book Proposal',
      'features': [
      {'feature': 'Proposal and Summary of proposed book', 'fees': '5000 INR (110 USD)', 'time': '1-2 days'}
      ]
    },
    {
      'title': 'Case report',
      'features': [
      {'feature': 'Clinical case study', 'fees': '15000 INR (260 USD)', 'time': '2-3 days'}
      ]
    },
    {
      'title': 'Research article',
      'features': [
      {'feature': 'Data analysis and statistics', 'fees': '25000 INR (280 USD)', 'time': '5-6 days'}
      ]
    },
    {
      'title': 'Review article',
      'features': [
      {'feature': 'All necessary efforts to write your work in papers', 'fees': '25000 INR (290 USD)', 'time': '2-3 weeks'}
      ]
    },
    {
      'title': 'Thesis chapter',
      'features': [
      {'feature': 'Any chapter of thesis', 'fees': '15000 INR (280 USD)', 'time': '5-6 days'}
      ]
    },
    {
      'title': 'Book',
      'features': [
      {'feature': 'Book writing services', 'fees': '25000 INR (200 USD)', 'time': '2-3 weeks'}
      ]
    },
    {
      'title': 'Thesis writing',
      'features': [
      {'feature': 'Proofreading, plagiarism free, AI free', 'fees': '65000 INR (440 USD)', 'time': '4-6 weeks'}
      ]
    }


    
  ];
}