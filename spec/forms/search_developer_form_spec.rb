require 'rails_helper'

RSpec.describe SearchDeveloperForm do
  describe '#search' do
    before do
      @language1 = create(:language, code: 'vn')
      @language2 = create(:language, code: 'en')
      @language3 = create(:language, code: 'jp')

      @programming_language1 = create(:programming_language, name: 'ruby')
      @programming_language3 = create(:programming_language, name: 'c++')

      create(:developer,
             email: 'abc2321@gmail.com',
             languages: [@language1, @language3],
             programming_languages: [@programming_language1, @programming_language3])
      create(:developer,
             email: 'abc2121@gmail.com',
             languages: [@language2],
             programming_languages: [create(:programming_language, name: 'js')])
      create(:developer,
             email: 'abc2341@gmail.com',
             languages: [@language3],
             programming_languages: [@programming_language3])
    end

    context 'with no params' do
      it 'returns no developers' do
        form = SearchDeveloperForm.new({})
        expect(form.search.size).to eq(0)
      end
    end

    context 'with params' do
      it 'returns a developer know a language' do
        form = SearchDeveloperForm.new(developers_search_form: { language_id: @language1.code })
        expect(form.search.size).to eq(1)
      end

      it 'returns empty if nobody know a language' do
        form = SearchDeveloperForm.new(developers_search_form: { language_id: 'cn' })
        expect(form.search.size).to eq(0)
      end

      it 'returns 2 developers know a language' do
        form = SearchDeveloperForm.new(developers_search_form: { language_id: @language3.code })
        expect(form.search.size).to eq(2)
      end

      it 'returns 1 developer know a programming language' do
        form = SearchDeveloperForm.new(developers_search_form: { programming_language_id: @programming_language1.name })
        expect(form.search.size).to eq(1)
      end

      it 'return 2 developers know a programming language' do
        form = SearchDeveloperForm.new(developers_search_form: { programming_language_id: @programming_language3.name })
        expect(form.search.size).to eq(2)
      end

      it 'return empty if nobody know a programming language' do
        form = SearchDeveloperForm.new(developers_search_form: { programming_language_id: 'non_exisiting_programming_language' })
        expect(form.search.size).to eq(0)
      end

      it 'return 1 developer know a programming language and a language' do
        form = SearchDeveloperForm.new(developers_search_form: { programming_language_id: @programming_language1.name, language: @language1.code })
        expect(form.search.size).to eq(1)
      end

      it 'return 2 developers know a programming language and a language' do
        form = SearchDeveloperForm.new(developers_search_form: { programming_language_id: @programming_language3.name, language_id: @language3.code })
        expect(form.search.size).to eq(2)
      end

      it 'return empty if nobody know both a language and a programming language' do
        form = SearchDeveloperForm.new(developers_search_form: { programming_language_id: @programming_language1.name, language_id: @language2.code })
        expect(form.search.size).to eq(0)
      end

    end
  end
end
