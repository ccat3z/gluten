/*
 * Licensed to the Apache Software Foundation (ASF) under one or more
 * contributor license agreements.  See the NOTICE file distributed with
 * this work for additional information regarding copyright ownership.
 * The ASF licenses this file to You under the Apache License, Version 2.0
 * (the "License"); you may not use this file except in compliance with
 * the License.  You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.apache.spark.sql.execution.datasources

import org.apache.spark.sql.GlutenSQLTestsBaseTrait
import org.apache.spark.sql.catalyst.plans.CodegenInterpretedPlanTest

class GlutenFileFormatWriterSuite
  extends FileFormatWriterSuite
  with GlutenSQLTestsBaseTrait
  with CodegenInterpretedPlanTest {

  test("gluten empty file should be skipped while write to file") {
    withTempPath {
      path =>
        spark.range(100).repartition(10).where("id = 50").write.parquet(path.toString)
        val partFiles = path
          .listFiles()
          .filter(f => f.isFile && !f.getName.startsWith(".") && !f.getName.startsWith("_"))
        // result only one row, gluten result is more reasonable
        assert(partFiles.length === 1)
    }
  }
}