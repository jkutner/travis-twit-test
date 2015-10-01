FROM heroku/jvm

RUN mkdir -p /usr/lib/jruby
ENV JRUBY_HOME /usr/lib/jruby
RUN curl -s -L  \
 https://s3.amazonaws.com/jruby.org/downloads/9.0.1.0/jruby-bin-9.0.1.0.tar.gz \
 --retry 3 | tar xz -C /usr/lib/jruby --strip-components=1
ENV PATH /usr/lib/jruby/bin:$PATH

RUN jruby -S gem install bundler -v 1.9.7 --no-ri --no-rdoc

COPY ["Gemfile", "Gemfile.lock", "/app/user/"]
RUN bundle install
COPY . /app/user/

ENV RACK_ENV development
ENV MAX_PUMA_THREADS 8