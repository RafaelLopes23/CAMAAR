# Classe base compartilhada por todos os modelos Active Record da aplicacao.
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end
