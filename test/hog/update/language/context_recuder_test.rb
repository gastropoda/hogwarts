require "minitest/autorun"

class ContextReducerTest < Minitest::Test
  ContextReducer = Hog::Update::Language::ContextReducer

  def test_single_sentence_remains_intact
    context = "short *bla bla* context."
    reduced = ContextReducer.new.reduce(context)
    assert_equal context, reduced
  end

  def test_single_clause_remains_intact
    context = "short *bla bla* context"
    reduced = ContextReducer.new.reduce(context)
    assert_equal context, reduced, "expected single clause to remain intact"
  end

  def test_preceding_sentence_is_removed
    sentence = "Sentence *bla bla* context."
    context = "Preceding sentence. #{sentence}"
    reduced = ContextReducer.new.reduce(context)
    assert_equal sentence, reduced
  end

  def test_preceding_sentence_is_removed_with_unfinished_context
    sentence = "Sentence *bla bla* context"
    context = "Preceding sentence. #{sentence}"
    reduced = ContextReducer.new.reduce(context)
    assert_equal sentence, reduced
  end

  def test_following_sentence_is_removed
    sentence = "Sentence *bla bla* context."
    context = "#{sentence} Following sentence."
    reduced = ContextReducer.new.reduce(context)
    assert_equal sentence, reduced
  end

  def add_huge_context clause
    "Preceding sentence! Another one? Some irrelevant shit; #{clause} Following sentence!? And more!!!"
  end

  def test_huge_context
    clause = "clause *bla bla* context!!?..."
    context = add_huge_context(clause)
    reduced = ContextReducer.new.reduce(context)
    assert_equal clause, reduced
  end

  def test_huge_context_complex_bold
    clause = "clause *bla; bla! or even bla?.* context!!?..."
    context = add_huge_context(clause)
    reduced = ContextReducer.new.reduce(context)
    assert_equal clause, reduced
  end
end

